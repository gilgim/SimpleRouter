//
//  RoutineModel.swift
//  Router
//
//  Created by Gaea on 2023/02/27.
//

import Foundation

struct Routine: Hashable {
    let id = UUID()
    /// 루틴 명
    let routineName: String?
    /// 루틴 포함 운동들
    let exercises: [Exercise]?
}
