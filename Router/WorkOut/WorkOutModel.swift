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
}
//  사용자가 실행하는 운동
struct WorkOutComponent: Hashable {
    let id = UUID()
}
