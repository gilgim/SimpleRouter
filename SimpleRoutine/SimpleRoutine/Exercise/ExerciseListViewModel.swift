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
    @ObservedObject var connectivityManager = WatchConnectivityManager.shared
    func deleteExercise(exercise: Exercise) {
        withAnimation {
            let viewContext = PersistenceController.shared.container.viewContext
            viewContext.delete(exercise)
            do {
                let encodeObject = ExerciseCodable(exercise: exercise, dataType: "d")
                let encoder = JSONEncoder()
                let json = try encoder.encode(encodeObject)
                connectivityManager.sendExercise(json)
                try viewContext.save()
            }
            catch {
                
            }
        }
    }
}
//  MARK: - 퀵 운동
class QuickCreateExerciseViewModel: ObservableObject {
    @ObservedObject var connectivityManager = WatchConnectivityManager.shared
    
    @Published var isShowEditor: Bool = false
    @Published var inputName: String = ""
    @Published var inputPart: String = ""
    @Published var randomSymbolName: String = {
        return symbolNames.randomElement() ?? "figure.walk"
    }()
    @Published var randomColorHex: String = {
        return colorHexs.randomElement() ?? "3CB371"
    }()
    
    var namePublisher = PassthroughSubject<Bool, Never>()
    var partPublisher = PassthroughSubject<Bool, Never>()
    
    var isNameFocus: Bool = false
    //  내리면 저장 가능
    func quickEditorShowToggle() {
        
        //  생성
        if isCreateExercise() {
            let context = PersistenceController.shared.container.viewContext
            let exercise = Exercise(context: context)
            let id = UUID()
            let date = Date()
            
            exercise.id = id
            exercise.createAt = date
            exercise.name = inputName
            exercise.part = inputPart
            exercise.symbolName = randomSymbolName
            exercise.colorHex = randomColorHex
            
            withAnimation {
                do {
                    let encodeObject = ExerciseCodable(exercise: exercise, dataType: "c")
                    let encoder = JSONEncoder()
                    let json = try encoder.encode(encodeObject)
                    connectivityManager.sendExercise(json)
                    
                    try context.save()
                }
                catch {
                    
                }
            }
            
            randomSymbolName = symbolNames.randomElement() ?? "figure.walk"
            randomColorHex = colorHexs.randomElement() ?? "3CB371"
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
        withAnimation {
            self.isShowEditor.toggle()
        }
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
    func changeSymbolAndColor() {
        randomSymbolName = symbolNames.randomElement() ?? "figure.walk"
        randomColorHex = colorHexs.randomElement() ?? "3CB371"
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
