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
	/// 운동 명
	let exerciseName: String?
	/// SFSymbol 사용
	let symbolName: String?
	/// Hex 코드로 작성
	let symbolColorHex: String?
	/// 부위
	let exercisePart: String?
}
