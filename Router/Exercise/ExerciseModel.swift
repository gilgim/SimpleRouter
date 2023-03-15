//
//  ExerciseModel.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//

import Foundation

/**
 운동명 및 부위명은 사용자 입력값이 무조건 존재해야하고 이미 있는 값으면
 알림이 필요하다.
 */
struct Exercise: Hashable {
    let id = UUID()
	/// 운동명
	let exerciseName: String
	/// SFSymbol 사용
	let symbolName: String
	/// Hex 코드로 작성
	let symbolColorHex: String
	/// 부위명
	let exercisePart: String
    //  ------------- <Realm Struct에는 존재하지 않는 Variable> -------------
    /// 휴식시간
    var restTime: Int16?
    /// 세트 수
    var set: Int16?
    
    /**
     -    parameters:
        -    exerciseName: 값이 할당되지 않으면 NotDefine으로 저장된다.
        -    exercisePart: 값이 할당되지 않으면  NotDefine으로 저장된다.
        -    symbolName: 기본 값은 걷는 심볼이다.
        -    symbolColorHex: 기본 값은 초록색이다.
        -    restTime: 운동을 생성할 때 저장되는 값이 아니며 생성 시 필요하다.
        -    set: 운동을 생성할 때 저장되는 값이 아니며 생성 시 필요하다.
     */
    init(exerciseName: String = "NotDefine", symbolName: String = "figure.walk", symbolColorHex: String = "3CB371", exercisePart: String = "NotDefine", restTime: Int16? = nil, set: Int16? = nil) {
        self.exerciseName = exerciseName
        self.symbolName = symbolName
        self.symbolColorHex = symbolColorHex
        self.exercisePart = exercisePart
        self.restTime = restTime
        self.set = set
    }
}
