//
//  ExerciseCreate.swift
//  Router
//
//  Created by Gaea on 2023/02/24.
//

import SwiftUI
import UIKit

struct ExerciseCreate: View {
	@Environment(\.presentationMode) var mode
	@StateObject var vm = ExerciseCreateViewModel()
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    ZStack {
                        Circle()
							.foregroundColor(Color(hex: self.vm.hex))
                            .background() {
								if self.vm.hex == "" {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.black)
                                }
                            }
                            .overlay(
								Image(systemName:self.vm.symbol)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .padding(20)
                            )
                    }
                    
                    VStack {
						TextField("운동명", text: $vm.exerciseName)
                            .modifier(RoundedRectangleModifier())
						TextField("부위명", text: $vm.exercisePart)
                            .modifier(RoundedRectangleModifier())
                    }
                }
                .frame(maxHeight: 120)
                SymbolColorView(hex: $vm.hex)
                    .padding(.vertical)
				SymbolImageView(symbol: $vm.symbol)
                    .padding(.vertical)
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("생성") {
					self.vm.createExercise()
					self.mode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct ExerciseCreate_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCreate()
    }
}

struct SymbolImageView: View {
    @Binding var symbol: String
    var iconRows: [GridItem] = .init(repeating: GridItem(.adaptive(minimum: UIScreen.main.bounds.height*0.3/6),spacing: 0), count: 5)
    var body: some View {
        VStack{
            HStack {
                Text("아이콘")
                    .font(Font.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.init(uiColor: .lightGray))
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: iconRows, spacing: 10) {
                    ForEach(symbolName, id: \.self) { symbolName in
                        Button {
                            symbol = symbolName
                        }label: {
                            Image(systemName:symbolName)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height*0.3)
        }
        .modifier(RoundedRectangleModifier())
    }
}

struct SymbolColorView: View {
    @Binding var hex: String
    var colorRows: [GridItem] = .init(repeating: GridItem(.adaptive(minimum: UIScreen.main.bounds.height*0.3/6),spacing: 0), count: 5)
    var body: some View {
        VStack{
            HStack {
                Text("색상")
                    .font(Font.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.init(uiColor: .lightGray))
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: colorRows, spacing: 10) {
                    ForEach(colorHexs, id: \.self) { hex in
                        Button {
                            self.hex = hex
                        }label: {
                            Circle()
                            .foregroundColor(Color(hex: hex))
                            .overlay(
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .padding(5)
                                    .foregroundColor(.white)
                            )
                            .padding(.bottom)
                        }
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height*0.3)
        }
        .modifier(RoundedRectangleModifier())
    }
}
