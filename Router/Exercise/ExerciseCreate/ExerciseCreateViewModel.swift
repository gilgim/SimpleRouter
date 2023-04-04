//
//  ExerciseCreateViewModel.swift
//  Router
//
//  Created by KimWooJin on 2023/02/25.
//

import Foundation
import Combine

class ExerciseCreateViewModel: ObservableObject {
    //  ========== 저장될 변수값 ==========
    @Published var idString: String = ""
    /// 사용자 커스텀 심볼 이름
	@Published var symbol: String = "figure.walk"
    /// 사용자 커스텀 심볼 색상
	@Published var hex: String = "3CB371"
    /// 사용자 입력 운동명
	@Published var exerciseName: String = ""
    /// 사용자 입력 운동 부위
	@Published var exercisePart: String = ""
    
	//  ========== 뷰 관련 ==========
    var viewType: ViewState = .nomal
    private var cancellables = Set<AnyCancellable>()
    
    /// alertMessage가 변경될 때 마다 뷰에서는 자동적으로 alert가 실행된다.
    @Published var alertMessage: String = "이것은 알림 기본값 입니다."
    var alertClosure: ()->() = {}
    
    //  뷰와 값을 바인딩하기 위한 초기함수.
    init() {
        $alertMessage.sink { [weak self] _ in
            self?.alertClosure()
        }
        .store(in: &cancellables)
    }
    /// 운동 생성 함수
    func createExercise() {
        guard self.exerciseName != "" else {alertMessage = "운동명을 입력해주세요.";return}
        guard self.exercisePart != "" else {alertMessage = "운동 부위를 입력해주세요.";return}
//        guard !(self.isExistExercise()) else {alertMessage = "존재하는 운동명 입니다.\n이름을 변경해주세요.";return}
        
        let realmExercise = RealmExercise()
        realmExercise.exerciseName = self.exerciseName
        realmExercise.exercisePart = self.exercisePart
        realmExercise.symbolName = self.symbol
        realmExercise.symbolColorHex = self.hex
        do {
            try realm().write({
                realm().add(realmExercise)
            })
        }
        catch {
            fatalError("\(error)")
        }
    }
    /// 운동 수정 함수
    func updateExercise() {
        guard self.exerciseName != "" else {alertMessage = "운동명을 입력해주세요.";return}
        guard self.exercisePart != "" else {alertMessage = "운동 부위를 입력해주세요.";return}
        if let object = realm().object(ofType: RealmExercise.self, forPrimaryKey: UUID(uuidString: self.idString)) {
            do {
                try realm().write({
                    object.exerciseName = self.exerciseName
                    object.exercisePart = self.exercisePart
                    object.symbolName = self.symbol
                    object.symbolColorHex = self.hex
                })
            }
            catch {
                fatalError("\(error)")
            }
        }
    }
    /// 운동명이 이미 존재하는 값을 알려주는 함수이다.
    /// 운동명이 "" 일 경우도 true로 처리한다.
    func isExistExercise() -> Bool {
        let object = realm().object(ofType: RealmExercise.self, forPrimaryKey: self.exerciseName)
        if object == nil {
            return false
        }
        else {
            return true
        }
    }
}
