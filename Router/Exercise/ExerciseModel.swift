//
//  ExerciseModel.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import Foundation

struct ExerciseModel {
   
}
struct Exercise: Hashable {
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
    /// 세트 수
    var set: Int16?
    init(exerciseName: String = "NotDefine", symbolName: String = "figure.walk", symbolColorHex: String = "3CB371", exercisePart: String = "NotDefine", restTime: Int16? = nil, set: Int16? = nil) {
        self.exerciseName = exerciseName
        self.symbolName = symbolName
        self.symbolColorHex = symbolColorHex
        self.exercisePart = exercisePart
        self.restTime = restTime
        self.set = set
    }
}
