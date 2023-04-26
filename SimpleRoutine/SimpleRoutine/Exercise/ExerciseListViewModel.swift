//
//  ExerciseListViewModel.swift
//  SimpleRoutine
//
//  Created by Gaea on 2023/04/26.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class ExerciseListViewModel: ObservableObject {
    
    
}
//  MARK: - 퀵 운동
class QuickCreateExerciseViewModel: ObservableObject {
    @Published var inputName: String = ""
    @Published var inputPart: String = ""
    @Published var isShowEditor: Bool = false
    var namePublisher = PassthroughSubject<Bool, Never>()
    var partPublisher = PassthroughSubject<Bool, Never>()
    
    var isNameFocus: Bool = false
    //  내리면 저장 가능
    func quickEditorShowToggle() {
        //  생성
        if isCreateExercise() {
            
        }
        //  초기화
        inputName = ""
        inputPart = ""
        //  키보드 내리기
        if self.isShowEditor {
            dismissKeyboard()
        }
        //  키보드 올리기
        else {
            namePublisher.send(true)
        }
        self.isShowEditor.toggle()
    }
    func isCreateExercise() -> Bool {
        if (inputName != "" && inputPart != "") && isShowEditor {
            return true
        }
        else {
            return false
        }
    }
    func quickEditorColor() -> Color {
        var editorColor: Color = .clear
        if isShowEditor && isCreateExercise() {
            editorColor = .blue
        }
        else if isShowEditor {
            editorColor = .init(uiColor: .systemYellow)
        }
        else {
            editorColor = .init(uiColor: .lightGray)
        }
        return editorColor
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct ExerciseListView2_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}
