//
//  WorkOutViewModel.swift
//  Router
//
//  Created by Gaea on 2023/03/14.
//

import Foundation
import Combine

class WorkOutViewModel: ObservableObject {
    @Published var routineName: String = ""
    @Published var runningList: [Running] = []
    @Published var completeRunningList: [Running] = []
    @Published var selectRunning: Running?
    
    func readRoutine() {
        guard let routineObject = realm().object(ofType: RealmRoutine.self, forPrimaryKey: self.routineName) else {return}
        let exerciseInfos = Array(routineObject.exercisesInfos)
        for exerciseInfo in exerciseInfos {
            let exercise = exerciseInfo.split(separator: "&")
            guard let realmExercise = realm().object(ofType: RealmExercise.self, forPrimaryKey: exercise[0]) else {continue}
            let running = Running(name: String(exercise[0]), symbolName: realmExercise.symbolName, symbolHex: realmExercise.symbolColorHex, set: Int(exercise[1])!, rest: Int(exercise[2])!, completeSet: 0, completeSetInfos: [], weight: 0, count: 0)
            runningList.append(running)
        }
    }
}

class RunningListViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var alertMessage: String = "이것은 알림 기본값 입니다."
    var alertClosure: ()->() = {}
    
    init() {
        $alertMessage.sink { [weak self] _ in
            self?.alertClosure()
        }
        .store(in: &cancellables)
    }
}

class SelectRunningViewModel: ObservableObject {
    enum RunningState: String {
        case start = "시작"
        case rest = "휴식"
        case complete = "완료"
    }
    @Published var runningState: RunningState = .start
    
    //  MARK: ViewAlert
    private var cancellables = Set<AnyCancellable>()
    
    @Published var alertMessage: String = "이것은 알림 기본값 입니다."
    var alertClosure: ()->() = {}
    
    //  MARK: 전체 운동 목록
    @Published var runningList: [Running] = []
    var runningListClosure: ([Running])->() = {_ in}
    
    //  MARK: 완료한 운동 목록
    @Published var completeRunningList: [Running] = []
    var completeRunningListClosure: ([Running])->() = {_ in}
    
    //  MARK: 선택한 운동
    @Published var selectRunning: Running?
    var selectRunningClosure: (Running?)->() = {_ in}
    
    var setInfos: [String] = []
    
    //  MARK: 한 세트 당 무게
    enum WeightUnit: String {
        case kg, lh
    }
    //  무게 단위
    @Published var weightUnit: WeightUnit = .kg
    //  저장되는 무게 문자열 값
    @Published var weightString: String = ""
    //  텍스트 필드에서 사용하는 것
    var weightText: String {
        get {
            return weightString
        }
        set {
            DispatchQueue.main.async {
                if newValue.filter({$0 == "."}).count == 1 || newValue.filter({$0 == "."}).count == 0  {
                    if newValue.allSatisfy({
                        return ($0 == "." || $0.isNumber)
                    })
                    {
                        self.weightString = newValue
                    }
                }
            }
        }
    }
    //  MARK: 한 세트 당 횟수
    @Published var count: Int = 0
    var countString: String {
        get {
            return count == 0 ? "" : String(count)
        }
        set {
            DispatchQueue.main.async {
                if newValue.allSatisfy({$0.isNumber}) {
                    self.count = Int(newValue) ?? 0
                }
            }
        }
    }
    //  1세트 운동 타이머
    var runningTimer: Timer?
    @Published var runningTime: Double = 0
    
    //  휴식시간 타이머
    var restTimer: Timer?
    var restTime: Int = 0
    @Published var restTimeString: String = ""
    
    @Published var currentSet: Int = 1
    
    init() {
        $alertMessage.sink { [weak self] _ in
            self?.alertClosure()
        }
        .store(in: &cancellables)
        
        //  View와 ViewModel runningList 바인딩 처리
        $runningList.sink { [weak self] value in
            self?.runningListClosure(value)
        }
        .store(in: &cancellables)
        
        //  View와 ViewModel completeRunningList 바인딩 처리
        $completeRunningList.sink { [weak self] value in
            self?.completeRunningListClosure(value)
        }
        .store(in: &cancellables)
        
        //  View와 ViewModel selectRunning 바인딩 처리
        $selectRunning.sink { [weak self] value in
            self?.selectRunningClosure(value)
            if let rest = value?.rest {
                self?.restTime = rest
                self?.restTimeString = "\(String(format: "%02d", rest/60)):\(String(format: "%02d", rest%60))"
            }
        }
        .store(in: &cancellables)
    }
    
    //  현재 사용자의 상태에 따라서 행동하는 제스처가 변화된다.
    func runningStateAction() {
        switch self.runningState {
            //  사용자가 운동을 시작해야하는 상태
        case.start:
            self.startWorkOut()
            self.runningState = .complete
            break
            //  사용자가 운동을 다해서 완료를 이벤트를 기다리는 상태
        case.complete:
            self.completeSet()
            self.runningState = .rest
            break
            //  완료를 눌러서 휴식 중인 상태
        case.rest:
            self.finishRest()
            break
        }
    }
    //  운동 시작
    private func startWorkOut() {
        runningTimer = .scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            self.runningTime += 0.01
        })
    }
    //  운동 완료
    private func completeSet() {
        runningTimer?.invalidate()
        self.restTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.restTime -= 1
            if self.runningState == .rest {
                self.restTimeString = "\(String(format: "%02d", self.restTime/60)):\(String(format: "%02d", self.restTime%60))"
            }
            else {
                self.restTimeString = ""
            }
            if self.restTime == 0 {
                self.finishRest()
            }
        })
    }
    private func finishRest() {
        if self.restTime != 0 {
            self.alertMessage = "아직 휴식하셔야합니다.\n바로 진행하시겠습니까?"
        }
        else {
            self.restAction()
        }
    }
    func restAction() {
        self.restTimer?.invalidate()
        self.runningState = .start
        guard let selectRunning else {return}
        self.restTime = selectRunning.rest
        self.currentSet += 1
    }
}
