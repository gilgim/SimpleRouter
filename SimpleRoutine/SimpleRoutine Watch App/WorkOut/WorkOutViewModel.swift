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
    var isRunning: PassthroughSubject<Bool, Never> = .init()
    var currentSetNumber: Int32 = 0
    var runningTime: Int = 0
    init() {
        isRunning.sink { [weak self] isRunning in
            if isRunning {
                
            }
            else {
                
            }
        }.store(in: &cancellables)
    }
    func runningStart() {
        
    }
    func runningStop() {
        
    }
    func restStart() {
        
    }
    func restStop() {
        
    }
    func runningFinish() {
        
    }
}
