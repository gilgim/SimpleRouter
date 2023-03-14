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
class SelectRunningViewModel: ObservableObject {
    //  MARK: ViewAlert
    private var cancellables = Set<AnyCancellable>()
    
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
    @Published var weight: Int = 0
    var weightString: String {
        get {
            return weight == 0 ? "" : String(weight)
        }
        set {
            DispatchQueue.main.async {
                if newValue.allSatisfy({$0.isNumber}) {
                    self.weight = Int(newValue) ?? 0
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
    
    var runningTimer: Timer?
    @Published var runningTime: Int = 0
    
    var restTimer: Timer?
    @Published var restTime: Int = 0
    @Published var currentSet: Int = 1
    
    enum RunningState: String {
        case start = "시작"
        case rest = "휴식 중"
        case complete = "완료"
    }
    @Published var runningState: RunningState = .start
    
    init() {
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
        }
        .store(in: &cancellables)
    }
    func chageRunningState() {
        switch self.runningState {
        case.start:
            startRunning()
        case.rest:
            //  이때는 휴식 다 하지 않았다 그래도 다시할거냐? 이렇게 울리기
            earlyFinishRest()
        case.complete:
            completeRunning()
        }
    }
    //  시작 버튼을 눌러서 운동을 시작 했을 때
    //  - 운동 시작이 늘어난다.
    func startRunning() {
        //  사용자 클릭 대기 상태
        runningState = .complete
        runningTime = 0
        runningTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.runningTime += 1
        })
    }
    //  - 한 세트 완료 후 휴식시간이 시작된다.
    //  - 세트 수 하나 증가
    func completeRunning() {
        guard let selectRunning else {return}
        if currentSet != selectRunning.set {
            runningTimer?.invalidate()
            runningTimer = nil
            runningState = .rest
            restTime = selectRunning.rest
            restTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                self.restTime -= 1
                if self.restTime == 0 {
                    self.restTimer?.invalidate()
                    let setInfo = "\(self.currentSet)&\(self.weight)&\(self.count)&\(self.runningTime)&\(selectRunning.rest-self.restTime)"
                    self.setInfos.append(setInfo)
                    self.runningState = .start
                    self.currentSet += 1
                }
            })
        }
        //  마지막 세트 일 때
        else {
            self.restTimer?.invalidate()
            let setInfo = "\(currentSet)&\(weight)&\(count)&\(runningTime)&\(restTime)"
            self.setInfos.append(setInfo)
            
            self.selectRunning = nil
        }
    }
    func earlyFinishRest() {
        guard let selectRunning else {return}
        self.restTimer?.invalidate()
        let setInfo = "\(self.currentSet)&\(self.weight)&\(self.count)&\(self.runningTime)&\(selectRunning.rest-self.restTime)"
        self.setInfos.append(setInfo)
        self.restTime = 0
        self.runningState = .start
        self.currentSet += 1
    }
    func isRestRemaining() -> Bool {
        guard let selectRunning else {return false}
        if selectRunning.rest == selectRunning.rest-restTime {
            return false
        }
        else {
            return true
        }
    }
}

class RunningListViewModel: ObservableObject {
    
}
