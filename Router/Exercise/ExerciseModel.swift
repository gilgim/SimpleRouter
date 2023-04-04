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
    //  MARK:   운동에 접근하기 위한 반응형 변수들
    let id = UUID()
    private var canacellable = Set<AnyCancellable>()
    let restPublisher = PassthroughSubject<Int16, Never>()
    let setPublisher = PassthroughSubject<Int16, Never>()

    let idString: String
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
    /// 세트 수
    var set: Int16?
    
    /// 운동 변수 설정 및 퍼블리셔 설정
    init(idString: String = "", exerciseName: String = "NotDefine", symbolName: String = "figure.walk", symbolColorHex: String = "3CB371", exercisePart: String = "NotDefine", restTime: Int16? = nil, set: Int16? = nil) {
        self.idString = idString
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
    //  퍼블리셔 할당을 위한 고유 id 할당
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    //  클래스 비교함수
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
}
