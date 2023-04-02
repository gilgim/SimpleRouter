//
//  CreateExerciseTests.swift
//  RouterTests
//
//  Created by Gaea on 2023/03/31.
//

import XCTest
@testable import Router

//  운동 생성 단위 테스트 
class CreateExerciseTests: XCTestCase {
    var createExerciseViewModel: ExerciseCreateViewModel!
    override func setUp() {
        super.setUp()
        //  뷰 모델 초기화
        createExerciseViewModel = ExerciseCreateViewModel()
    }
    override func tearDown() {
        createExerciseViewModel = nil
        super.tearDown()
    }
    
    //  아이콘 미선택
    //  ->
    
    //  아이콘 선택
    //  ->
    
    //  아이콘 색상 미선택
    //  ->
    
    //  아이콘 색상 선택
    //  ->
    
    //  운동 이름 미작성
    //  ->
    
    //  운동 이름 작성
    //  ->
    
    //  운동 부위 미작성
    //  ->
    
    //  운동 부위 작성
    //  ->
    
    //  생성 버튼 클릭
    //  -> 운동 추가
    
    //  작성 후 뒤로가기
    //  -> 기존 작성 항목 사라짐
    
}
