//
//  ExerciseListView.swift
//  SimpleRoutine
//
//  Created by Gaea on 2023/04/26.
//

import SwiftUI

struct ExerciseListView: View {
    @State var text: String = ""
    @State var isQuickCreateShow: Bool = false
    @State var isQuickCreateAble: Bool = false
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())]) {
                        
                    }
                }
                QuickCreateExerciseView()
            }
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}

struct QuickCreateExerciseView: View {
    @State var test: Bool = false
    @State var test2: Bool = false
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
                Circle().foregroundColor(.white)
                    .padding(.trailing, 30)
                Spacer()
                VStack(spacing: 5) {
                    CustomTextField(text: $vm.inputName, isFocus: vm.namePublisher) {
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
                    CustomTextField(text: $vm.inputPart,isFocus: vm.partPublisher) {
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
            .animation(.default, value: vm.isShowEditor)
            .animation(.default, value: vm.isCreateExercise())
            
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
        .offset(y:vm.isShowEditor ? 0 : 110)
        .padding(.horizontal,16)
        .padding(.bottom, 20)
        .animation(.default, value: vm.isShowEditor)
        .animation(.default, value: vm.isCreateExercise())
    }
}
