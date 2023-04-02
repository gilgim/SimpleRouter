//
//  CreateRoutineTests.swift
//  RouterTests
//
//  Created by Gaea on 2023/03/31.
//

import XCTest
@testable import Router

//  루틴 생성 단위 테스트 
class CreateRoutineTests: XCTestCase {
    var createRoutineViewModel: RoutineCreateViewModel!
    override func setUp() {
        super.setUp()
        //  뷰 모델 초기화
        createRoutineViewModel = RoutineCreateViewModel()
    }
    override func tearDown() {
        createRoutineViewModel = nil
        super.tearDown()
    }
    
    //  사전조건 : 루틴 이름 미작성 후
    //  생성 버튼 클릭
    //  ->
    
    //  사전조건 : 루틴 이름 작성 후
    //  생성 버튼 클릭
    //  ->
    
    //  사전조건 : 추가된 운동이 없음
    //  생성 버튼 클릭
    //  ->

    //  사전조건 : 추가된 운동이 있음
    //  생성 버튼 클릭
    //  ->

    //  루틴에 운동 추가 버튼 클릭
    //  ->
    
    //  사전조건 : 추가된 운동이 있음
    //  버튼 더보기 클릭
    //  ->
    
    //  사전조건 : 추가된 운동이 있음
    //  수정 버튼 클릭
    //  ->
    
    //  사전조건 : 추가된 운동이 있음
    //  swipe 삭제 버튼 클릭
    //  ->
    
    //  사전조건 : 추가된 운동이 있음
    //  드래그 운동 배열 변경
    //  ->   
    
    //  FIXME: 추후 더보기 기능 추가
    //  사전조건 : 더보기 클릭
    //  
}
