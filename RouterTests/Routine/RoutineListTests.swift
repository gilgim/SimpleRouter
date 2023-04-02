//
//  RoutineTests.swift
//  RouterTests
//
//  Created by Gaea on 2023/03/31.
//

import XCTest
@testable import Router

//  루틴 목록 기능 단위 테스트
class RoutineListTests: XCTestCase {
    var routineListViewModel: RoutineViewModel!
    override func setUp() {
        super.setUp()
        //  뷰 모델 초기화
        routineListViewModel = RoutineViewModel()
    }
    override func tearDown() {
        routineListViewModel = nil
        super.tearDown()
    }
    
    //  + 버튼 클릭
    //  ->
    
    //  Swipe 업데이트 버튼 클릭
    //  -> RoutineCreateView 호출
    
    //  Swipe 삭제 버튼 클릭
    //  -> 해당 루틴 삭제, 루틴 데이터 삭제
    
    //  ... 클릭
    //  -> 
}
