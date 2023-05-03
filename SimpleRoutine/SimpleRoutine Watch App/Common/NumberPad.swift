//
//  NumberPad.swift
//  SimpleRoutine Watch App
//
//  Created by Gilgim on 2023/05/02.
//

import SwiftUI

struct NumberPad: View {
    @Environment(\.presentationMode) var mode
    let title: String
    @Binding var isShow: Bool
    @Binding var numberString: String
    var body: some View {
        VStack {
            Text(numberString)
                .frame(height: 20)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(1..<10) { number in
                    Button {
                        if numberString.count < 3 {
                            numberString += String(number)
                        }
                    }label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 13)
                                .foregroundColor(.gray)
                            Text("\(number)")
                                .padding(4)
                        }
                    }
                }
                Button{
                    if numberString != "" {
                        numberString.removeLast()
                    }
                }label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(.gray)
                        Image(systemName: "delete.left")
                            .foregroundColor(.red)
                    }
                }
                Button{
                    if numberString != "" && numberString.count < 3 {
                        numberString += "0"
                    }
                }label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(.gray)
                        Text("0")
                            .padding(4)
                    }
                }
                Button{
                    withAnimation {
                        self.isShow = false
                    }
                }label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(.gray)
                        Image(systemName: "plus")
                    }
                }
            }
            .buttonStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Text(title)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    numberString = ""
                    mode.wrappedValue.dismiss()
                }label: {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}

struct NumberPad_Previews: PreviewProvider {
    @State var temp: String = ""
    static var previews: some View {
        NumberPad(title: "세트", isShow: .constant(false), numberString: NumberPad_Previews().$temp)
    }
}
