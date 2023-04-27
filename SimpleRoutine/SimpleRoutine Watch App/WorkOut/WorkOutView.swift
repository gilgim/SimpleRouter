//
//  WorkOutView.swift
//  SimpleRoutine Watch App
//
//  Created by Gaea on 2023/04/21.
//

import SwiftUI
import Combine
import CoreData
import WatchConnectivity

struct WorkOutView: View {
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Exercise.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.createAt, ascending: true)]
    ) private var exercises: FetchedResults<Exercise>
    var body: some View {
        TabView {
            RunningView()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(exercises) { exercise in
                        VStack(spacing: 0) {
                            Button {
                                
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
        .onAppear() {
            connectivityManager.exerciseSendAction = { object in
                withAnimation {
                    let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
                    let context = PersistenceController.shared.container.viewContext
                    let exercise = try? JSONDecoder().decode(ExerciseCodable.self,from: object)
                    if let exercise = exercise {
                        switch exercise.dataType  {
                        case "c":
                            do {
    //                            let exercises = try context.fetch(fetchRequest)
    //                            for exercise in exercises {
    //                                context.delete(exercise)
    //                            }
                                let coreExercise = Exercise(context: context)
                                coreExercise.convertExercise(codable: exercise)
                                try context.save()
                            }
                            catch {
                                
                            }
                        case "r":
                            break
                        case "u":
                            break
                        case "d":
                            do {
                                let exercises = try context.fetch(fetchRequest)
                                let target = exercises.filter({$0.id == exercise.id})
                                guard !(target.isEmpty) else {return}
                                context.delete(target[0])
                                try context.save()
                            }
                            catch {
                                
                            }
                            break
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
}
struct RunningView: View {
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    var body: some View {
        Button("Test Button") {
            WatchConnectivityManager.shared.sendMessage("Test")
        }
    }
}
struct WorkOutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkOutView()
    }
}
