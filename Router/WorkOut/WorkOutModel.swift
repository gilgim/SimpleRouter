//
//  WorkOutModel.swift
//  Router
//
//  Created by Gaea on 2023/03/06.
//

import Foundation

//  운동 리스트를 저장하기 위한 자료
struct WorkOut: Hashable {
    let id = UUID()
	let routineName: String
	let workOuts: [WorkOutComponent]
	let date: String
    
    //  사용자가 실행하는 운동
    struct WorkOutComponent: Hashable {
        let id = UUID()
        //  운동이름
        let exerciseName: String
        var symbolInfo: [String]
        //  세트 [무게, 횟수, 시간]
        var setDetail: [Int: [Int]]
        var restTime: Int
        init(exerciseName: String, symbolInfo: [String] = ["figure.walk","000000"], setDetail: [Int : [Int]], restTime: Int) {
            self.exerciseName = exerciseName
            self.symbolInfo = symbolInfo
            self.setDetail = setDetail
            self.restTime = restTime
        }
    }
}
