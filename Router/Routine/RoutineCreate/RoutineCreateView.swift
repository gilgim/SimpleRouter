//
//  RoutineCreateView.swift
//  Router
//
//  Created by KimWooJin on 2023/02/26.
//

import SwiftUI

struct RoutineCreateView: View {
	@State var isPresentExercise = false
	@State var selectExercise: Exercise? = nil
    var body: some View {
		List {
			Section("운동 목록") {
				VStack {
					Button {
						self.isPresentExercise = true
					}label: {
						HStack {
							Spacer()
							Image(systemName: "plus")
							Spacer()
						}
					}
				}
			}
		}
		.onChange(of: selectExercise, perform: { _ in
			if selectExercise != nil {
				self.isPresentExercise = false
			}
		})
		.popover(isPresented: $isPresentExercise, content: {
			ExerciseView(selctExercise: $selectExercise)
		})
		.navigationTitle("루틴 생성")
		.navigationBarTitleDisplayMode(.large)
    }
}

struct RoutineCreateView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCreateView()
    }
}
