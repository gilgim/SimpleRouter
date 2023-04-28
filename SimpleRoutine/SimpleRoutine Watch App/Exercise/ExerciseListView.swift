//
//  ExerciseListView.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/04/28.
//

import SwiftUI
import CoreData

struct ExerciseListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Exercise.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.createAt, ascending: true)]
    ) private var exercises: FetchedResults<Exercise>
    
    @StateObject var vm = ExerciseListViewModel()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(exercises) { exercise in
                    VStack(spacing: 0) {
                        NavigationLink {
                            WorkOutView(selectExercise: exercise)
                        } label: {
                            ZStack {
                                Circle().foregroundColor(.init(hex: exercise.colorHex ?? "3CB371"))
                                Image(systemName: exercise.symbolName ?? "figure.walk")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(width: 100)
                }
            }
        }
        .overlay {
            if exercises.isEmpty {
                Text("iPhone에서 운동을 생성해주세요.")
                    .frame(height: 100)
            }
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}
