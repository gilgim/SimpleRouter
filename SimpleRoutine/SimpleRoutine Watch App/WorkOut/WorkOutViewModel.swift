//
//  WorkOutViewModel.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/04/28.
//

import Foundation
import Combine
class RunningViewModel: ObservableObject {
    var cancellables: Set<AnyCancellable> = .init()
    @Published var exercise: Exercise = Exercise()
    var runningTimer: Timer?
    
    //  타이머만 껐다 킨다. 시간을 초기화 안함
    var isRunning: PassthroughSubject<Bool, Never> = .init()
    var currentSetNumber: Int32 = 0
    @Published var runningTime: Int = 0
    var runningTimeText: String {
        get {
            var msecond: Int = 0
            var second: Int = 0
            var minute: Int = 0
            msecond = runningTime % 100
            second = (runningTime / 100) % 60
            minute = ((runningTime / 100) / 60)
            var returnString = ""
            if runningTime >= 360000 {
                returnString = "\(String(format: "%03d", minute)):\(String(format: "%02d", second)):\(String(format: "%02d", msecond))"
            }
            else {
                returnString = "\(String(format: "%02d", minute)):\(String(format: "%02d", second)):\(String(format: "%02d", msecond))"
            }
            return returnString
        }
    }
    
    @Published var isAlert: Bool = false
    var alertMessage: String = ""
    var alertEvent: PassthroughSubject<String?, Never> = .init()
    init() {
        isRunning.sink { [weak self] isRunning in
            if isRunning {
                self?.runningTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
                    self?.runningTime += 1
                })
            }
            else {
                self?.runningTimer?.invalidate()
                self?.runningTimer = nil
            }
        }.store(in: &cancellables)
        
        alertEvent.sink { [weak self] message in
            if let message {
                self?.alertMessage = message
                self?.isAlert = true
            }
        }.store(in: &cancellables)
    }
    func runningStart() {
        isRunning.send(true)
    }
    func runningStop() {
        isRunning.send(false)
    }
    func restStart() {
        
    }
    func restStop() {
        
    }
    func runningFinish() {
        
    }
}