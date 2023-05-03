//
//  RunningViewModel.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/05/03.
//

import Foundation
import Combine

class RunningViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = .init()
    @Published var isAlert: Bool = false
    @Published var alertMessage: String = ""
    var alertEvent: PassthroughSubject<String, Never> = .init()
    init() {
        alertEvent.sink { [weak self] message in
            if message != "" {
                self?.alertMessage = message
                self?.isAlert = true
            }
        }.store(in: &cancellables)
    }
}
