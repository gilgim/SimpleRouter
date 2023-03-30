//
//  RouterApp.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//
//  MARK: - App 목적
/// 1.  운동 할 때 운동 시간 및 횟수 체크
/// 2.  운동 시 이전 운동 몇키로 몇 세트로 진행했는지 체크
/// 3.  휴식 시간 체크
/// 4.  운동 총 시간 체크
/// 5.  애플 워치 연동해서 폰은 다른 활동을 할 수 있게 한다.

import SwiftUI

@main

struct RouterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct Configuration {
    struct LargeDevice {
        let listCircleSize = CGSize(width: 90, height: 90)
    }
    struct SmallDevice {
        let listCircleSize = CGSize(width: 80, height: 80)
    }
}
