//
//  ExerciseListTests.swift
//  RouterTests
//
//  Created by Gaea on 2023/03/31.
//

import XCTest
@testable import Router

//  운동 목록 기능 단위 테스트
class ExerciseListTests: XCTestCase {
    var exerciseListViewModel: ExerciseViewModel!
    override func setUp() {
        super.setUp()
        //  뷰 모델 초기화
        exerciseListViewModel = ExerciseViewModel()
    }
    override func tearDown() {
        exerciseListViewModel = nil
        super.tearDown()
    }
    //  네비게이션 바 생성 버튼 클릭
    //  -> CreateView 호출
    
    
    //  Swipe 드래그해서 업데이트 버튼 클릭
    //  -> CreateView 호출, 이름 수정 불가
    
    
    //  Swipe 드래그해서 삭제 버튼 클릭
    //  -> 해당 객체 삭제, 해당 운동이 포함되어 있는 루틴 갱신
    
    
}
