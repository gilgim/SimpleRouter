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
