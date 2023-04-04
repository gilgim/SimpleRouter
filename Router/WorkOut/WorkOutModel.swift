//
//  WorkOutModel.swift
//  Router
//
//  Created by Gaea on 2023/03/14.
//

import Foundation

struct WorkOut {
    let routineName: String
    let date: Date
    let runningList: [Running]
    let completeRunningList: [Running]
}
struct Running: Hashable {
    let id = UUID()
    let name: String
    let symbolName: String
    let symbolHex: String
    let set: Int
    let rest: Int
    var completeSet: Int
    //  세트넘버&무게&횟수&운동시간&휴식시간
    var completeSetInfos: [String]
}
