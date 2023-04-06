//
//  WorkOutViewModel.swift
//  Router
//
//  Created by Gaea on 2023/03/14.
//

import Foundation
import Combine
import SwiftUI
import SnapKit
import AVFoundation

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
            guard let realmExercise = realm().object(ofType: RealmExercise.self, forPrimaryKey: UUID(uuidString: String(exercise[0]))) else {continue}
            let running = Running(name: String(exercise[1]), symbolName: realmExercise.symbolName, symbolHex: realmExercise.symbolColorHex, set: Int(exercise[2])!, rest: Int(exercise[3])!, completeSet: 0, completeSetInfos: [])
            runningList.append(running)
        }
    }
}

class RunningListViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    @Published var isDismiss = false
    @Published var isComplete = false
    @Published var alertMessage: String = "이것은 알림 기본값 입니다."
    var alertClosure: ()->() = {}
    var alertAction: ()->() = {}
    
    //  MARK: 전체 운동 목록
    @Published var runningList: [Running] = []
    //  MARK: 완료한 운동 목록
    @Published var completeRunningList: [Running] = []
    
    init() {
        $alertMessage.sink { [weak self] _ in
            self?.alertClosure()
        }
        .store(in: &cancellables)
    }
    func stopRoutine() {
        self.alertMessage = "해당 루틴을 중단하시겠습니까?\n(저장되지 않습니다.)"
        self.alertAction = {
            self.isDismiss = true
        }
    }
    func finishRoutine() {
        if runningList.count != 0 {
            self.alertMessage = "모든 운동을 완료하지 않았습니다. 종료하시겠습니까?"
            self.alertAction = {
                self.saveWorkOut()
                self.isComplete = true
            }
        }
        else if runningList.count == 0 {
            self.saveWorkOut()
            self.isComplete = true
        }
    }
    func saveWorkOut() {
        print(completeRunningList)
    }
}

class SelectRunningViewModel: ObservableObject {
    enum RunningState: String {
        case start = "시작"
        case rest = "휴식"
        case complete = "완료"
    }
    @Published var runningState: RunningState = .start
    var audioPlayer: AVAudioPlayer!
    var backgroundTimer: Timer?
    var backgroundTimeStack = 0
    
    //  MARK: ViewAlert
    private var cancellables = Set<AnyCancellable>()
    
    var scenePhase = PassthroughSubject<ScenePhase, Never>()
    @Published var alertMessage: String = "이것은 알림 기본값 입니다."
    var alertClosure: ()->() = {}
    var alertAction: ()->() = {}
    
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
    var weight: Double = 0
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
    @Published var runningTimeString: String = "00:00:00"
    @Published var runningTime: Int = 0
    
    //  휴식시간 타이머
    var restTimer: Timer?
    var restTime: Int = 0
    @Published var restTimeString: String = ""
    
    @Published var currentSet: Int = 1
    init() {
        scenePhase.sink { [weak self] value in
            switch value {
            case.active:
                self?.intoActive()
            case.inactive:
//                self?.intoInactive()
                break
            case.background:
                self?.intoBackground()
            @unknown default:
                break
            }
        }
        .store(in: &cancellables)
        
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
    ///  현재 사용자의 버튼 상태에 따라 다른 액션 실행
    func runningStateAction() {
        switch self.runningState {
            
        //  사용자가 운동을 시작해야하는 상태
        case.start:
            //  시작 버튼을 눌렀을 때 운동 타이머 실행 후 버튼 상태 완료로 변경
            self.startWorkOut()
            self.runningState = .complete
            break
            
        //  사용자가 운동을 다해서 완료를 이벤트를 기다리는 상태
        case.complete:
            //  완료 버튼을 눌렀을 때 휴식 타이머 실행 후 버튼 상태 휴식으로 변경
            self.completeSet()
            self.runningState = .rest
            break
            
        //  완료를 눌러서 휴식 중인 상태
        case.rest:
            //  휴식은 보통 모두 채워야하지만 이례적으로 버튼을 눌른다면 팝업을 띄움.
            self.finishRest()
            break
        }
    }
    /// 세트 정보 저장함수
    private func saveSetInfo() {
        if let selectRunning {
            self.weight = Double(self.weightString) ?? 0
            let setInfo = "\(self.currentSet)&\(self.weight)&\(self.count)&\(self.runningTime)&\(selectRunning.rest - self.restTime)"
            self.setInfos.append(setInfo)
            self.weightString = ""
            self.countString = "0"
        }
    }
    /// 시작 버튼을 눌러 운동이 시작될 때 함수
    private func startWorkOut() {
        runningTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.runningTime += 1
            let s = String(format: "%02d", self.runningTime%60)
            let m = String(format: "%02d", (self.runningTime/60)%60)
            let h = String(format: "%02d", self.runningTime/60/60)
            self.runningTimeString = "\(h):\(m):\(s)"
        })
    }
    /// 운동 완료 함수
    private func completeSet() {
        runningTimer?.invalidate()
        self.restTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.restTime > 0  {
                self.restTime -= 1
            }
            if self.runningState == .rest {
                self.restTimeString = "\(String(format: "%02d", self.restTime/60)):\(String(format: "%02d", self.restTime%60))"
            }
            else {
                self.restTimeString = ""
            }
            if self.restTime <= 0 {
                if let selectRunning = self.selectRunning,
                    selectRunning.set > self.currentSet {
                    self.finishRest()
                }
                else if let selectRunning = self.selectRunning, selectRunning.set <= self.currentSet {
                    self.finishExercise()
                }
            }
        })
    }
    /// 휴식이 종료되었을 때 실행되는 함수
    private func finishRest() {
        if self.restTime > 0 {
            self.alertMessage = "아직 휴식하셔야합니다.\n바로 진행하시겠습니까?"
            self.alertAction = {
                guard self.runningState == .rest else {return}
                if let selectRunning = self.selectRunning, self.currentSet < selectRunning.set {
                    self.restAction()
                }
                else {
                    self.finishExercise()
                }
            }
        }
        else {
            self.restAction()
        }
    }
    private func restAction() {
        self.restTimer?.invalidate()
        self.runningState = .start
        self.saveSetInfo()
        guard let selectRunning else {return}
        self.restTime = selectRunning.rest
        self.restTimeString = "\(String(format: "%02d", self.restTime/60)):\(String(format: "%02d", self.restTime%60))"
        self.runningTime = 0
        self.runningTimeString = "00:00:00"
        self.currentSet += 1
    }
    
    /// 하나의 운동을 종료하는 함수
    func finishExercise() {
        guard var selectRunning else {return}
        self.saveSetInfo()
        selectRunning.completeSet = currentSet
        selectRunning.completeSetInfos = setInfos
        self.runningList = self.runningList.filter({$0.id != selectRunning.id})
        self.completeRunningList.append(selectRunning)
        self.completeRunningList = self.completeRunningList
        self.runningTimer?.invalidate()
        self.runningTimer = nil
        self.restTimer?.invalidate()
        self.restTimer = nil
        self.backgroundTimer?.invalidate()
        self.backgroundTimer = nil
        self.selectRunning = nil
    }
    /// 운동 완료 시점에 완료버튼 클릭
    func completeButtonAction() {
        self.alertAction = {
            self.finishExercise()
        }
        self.alertMessage = "완료하지 않은 세트가 있습니다.완료하시겠습니까?\n(완료하지 않은 세트는 저장되지 않습니다.)"
    }
    /// 앱이 백그라운드에 진입할 때
    func intoBackground() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
        self.backgroundTimeStack = components.hour! * 3600 + components.minute! * 60 + components.second!
        
        if let selectRunning, self.runningState == .rest {
            //  일시정지 판단
            guard restTimer != nil else {return}
            let content = UNMutableNotificationContent()
            content.title = selectRunning.name + " \(currentSet)세트 휴식 완료"
            content.body = selectRunning.set == currentSet ? "운동이 완료되었습니다. 확인해주세요.":"휴식이 완료되었습니다. 운동을 진행해주세요."
            content.sound = .default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(restTime), repeats: false)
            let request = UNNotificationRequest(identifier: "restFinish", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            playNoSound()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(restTime-1)) {
                self.backgroundTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
//                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    print("Hi")
                })
            }
        }
    }
    /// 앱이 활성화 되었을 때
    func intoActive() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["restFinish"])
        stopNoSound()
        self.backgroundTimer?.invalidate()
        self.backgroundTimer = nil
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
        let current = components.hour! * 3600 + components.minute! * 60 + components.second!
        let diffSecond = current - self.backgroundTimeStack
        
        switch runningState {
        case.rest:
            guard restTimer != nil else {return}
            self.restTime -= diffSecond
            if restTime > 0 {
                self.restTimeString = "\(String(format: "%02d", self.restTime/60)):\(String(format: "%02d", self.restTime%60))"
            }
            else {
                self.restTimeString = "00:00:00"
            }
            if let selectRunning, self.restTime <= 0 &&  self.currentSet < selectRunning.set {
                self.finishRest()
            }
            else if let selectRunning, self.restTime <= 0 &&  self.currentSet == selectRunning.set {
                self.finishExercise()
            }
        case.complete:
            guard runningTimer != nil else {return}
            self.runningTime += diffSecond
        default:
            break
        }
    }
    /// 일시정지 할 때
    func stopWorkOut() {
        let vc = PauseViewController()
        vc.restartPublisher.sink { [weak self] value in
            if value {
                self?.restartWorkOut()
            }
        }.store(in: &cancellables)
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true)
        
        self.restTimer?.invalidate()
        self.runningTimer?.invalidate()
        
        self.restTimer = nil
        self.runningTimer = nil
    }
    /// 일시정지 후 재실행 되었을 때
    func restartWorkOut() {
        switch runningState {
        case.complete:
            self.startWorkOut()
            break
        case.rest:
            self.completeSet()
            break
        default:
            break
        }
    }
    //  운동 중 백그라운드 진입 시에만 작동한다.
    func playNoSound() {
        guard let url = Bundle.main.url(forResource: "NoSound", withExtension: "wav") else {
            print("음악 파일을 찾을 수 없습니다.")
            
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1 // 반복 재생
            audioPlayer.play()
        } catch {
            print("오디오 재생 중 에러 발생: \(error.localizedDescription)")
        }
    }
    func stopNoSound() {
        audioPlayer?.stop()
    }
}
