//
//  ExerciseModel.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import Foundation
import Combine
struct ExerciseModel {
   
}
class Exercise: Hashable {
    private var canacellable = Set<AnyCancellable>()
    let id = UUID()
	/// 운동 명
	let exerciseName: String
	/// SFSymbol 사용
	let symbolName: String
	/// Hex 코드로 작성
	let symbolColorHex: String
	/// 부위
	let exercisePart: String
    /// 휴식시간
    var restTime: Int16?
    let restPublisher = PassthroughSubject<Int16, Never>()
    /// 세트 수
    var set: Int16?
    let setPublisher = PassthroughSubject<Int16, Never>()
    
    init(exerciseName: String = "NotDefine", symbolName: String = "figure.walk", symbolColorHex: String = "3CB371", exercisePart: String = "NotDefine", restTime: Int16? = nil, set: Int16? = nil) {
        self.exerciseName = exerciseName
        self.symbolName = symbolName
        self.symbolColorHex = symbolColorHex
        self.exercisePart = exercisePart
        self.restTime = restTime
        self.set = set
        self.setPublisher.sink { [weak self] set in
            self?.set = set
        }
        .store(in: &canacellable)
        self.restPublisher.sink { [weak self] rest in
            self?.restTime = rest
        }
        .store(in: &canacellable)
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
}
