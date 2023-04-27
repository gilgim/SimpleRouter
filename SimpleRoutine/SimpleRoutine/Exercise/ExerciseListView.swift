//
//  ExerciseListView.swift
//  SimpleRoutine
//
//  Created by Gaea on 2023/04/26.
//

import SwiftUI

struct ExerciseListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Exercise.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.createAt, ascending: true)]
    ) private var exercises: FetchedResults<Exercise>
    
    @StateObject var vm: ExerciseListViewModel = .init()
    
    @State var isWorkOutPush: Bool = false
    @State var selectExercise: Exercise? = nil
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Rectangle().frame(height: 40)
                ScrollView {
                    LazyVGrid(columns: [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 24) {
                        ForEach(exercises) { exercise in
                            VStack(spacing: 0) {
                                Text(exercise.part ?? "nothing")
                                    .lineLimit(1)
                                Menu {
                                    Button {
                                        self.selectExercise = exercise
                                        self.isWorkOutPush.toggle()
                                    }label: {
                                        Label("운동", systemImage: "figure.run")
                                    }
                                    
                                    Button {
                                        
                                    }label: {
                                        Label("수정", systemImage: "pencil")
                                    }
                                    
                                    Section {
                                        Button(role: .destructive) {
                                            self.vm.deleteExercise(exercise: exercise)
                                        }label: {
                                            Label("삭제", systemImage: "trash")
                                        }
                                    }
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
                                Text(exercise.name ?? "nothing")
                                    .lineLimit(1)
                            }
                            .frame(width: 100)
                        }
                    }
                    .padding(.horizontal, 16)
                    Spacer().frame(height: 40)
                }
            }
            VStack {
                Spacer()
                QuickCreateExerciseView()
            }
        }
        .navigationDestination(isPresented: $isWorkOutPush) {
            WorkOutView(exercise: $selectExercise)
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}

struct QuickCreateExerciseView: View {
    @StateObject var vm: QuickCreateExerciseViewModel = .init()
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .foregroundColor(vm.quickEditorColor())
                .onTapGesture {
                    vm.quickEditorShowToggle()
                }
            
            VStack {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(.top, 10)
                    .foregroundColor(.white.opacity(0.7))
                Spacer()
            }
            
            HStack {
                Button {
                    vm.changeSymbolAndColor()
                }label: {
                    ZStack {
                        Circle().foregroundColor(.init(hex: vm.randomColorHex))
                        Image(systemName: vm.randomSymbolName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35,height: 35)
                            .foregroundColor(.white)
                            .opacity(vm.isShowEditor ? 1 : 0)
                    }
                }
                .padding(.trailing, 30)
                
                Spacer()
                VStack(spacing: 5) {
                    CustomTextField("운동이름", text: $vm.inputName, isFocus: vm.namePublisher) {
                        vm.partPublisher.send(true)
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .tint(.white)
                    
                    Divider()
                        .overlay {
                            Color.white
                        }
                        .padding(.bottom, 5)
                    CustomTextField("운동부위", text: $vm.inputPart,isFocus: vm.partPublisher) {
                        vm.quickEditorShowToggle()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .tint(.white)
                    Divider()
                        .overlay {
                            Color.white
                        }
                }
                .padding(.trailing, 30)
            }
            .frame(height: 80)
            .padding(.horizontal, 16)
            .padding(.top,20)
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.diamond.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .opacity(vm.isCreateExercise() ? 1 : 0)
                        .transition(.slide)
                        .foregroundColor(.green)
                        .padding(.top, 10)
                        .padding(.trailing, 10)
                }
                Spacer()
            }
        }
        .frame(height: 120)
        .padding(.horizontal,16)
        .padding(.bottom, vm.isShowEditor ? 20 : -95)
        .animation(.default, value: vm.isShowEditor)
        .animation(.default, value: vm.isCreateExercise())
        .background(.clear)
    }
}
