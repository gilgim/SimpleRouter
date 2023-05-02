//
//  NumberPad.swift
//  SimpleRoutine Watch App
//
//  Created by Gilgim on 2023/05/02.
//

import SwiftUI

struct NumberPad: View {
    @Binding var numberString: String
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(1..<10) { number in
                Button {
                    
                }label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(.gray)
                        Text("\(number)")
                            .padding(7)
                    }
                }
            }
            Button{
                
            }label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(.gray)
                    Image(systemName: "delete.left")
                        .foregroundColor(.red)
                }
            }
            Button{
                
            }label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(.gray)
                    Text("0")
                        .padding(7)
                }
            }
            Button{
                
            }label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(.gray)
                    Image(systemName: "delete.left")
                        .foregroundColor(.red)
                }
            }
        }
        .buttonStyle(.plain)
        .padding(.top, 30)
    }
}

struct NumberPad_Previews: PreviewProvider {
    static var previews: some View {
        NumberPad(numberString: .constant(""))
    }
}
