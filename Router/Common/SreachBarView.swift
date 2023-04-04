//
//  SearchBarView.swift
//  Router
//
//  Created by Gaea on 2023/02/24.
//

import SwiftUI

struct SearchBarView: View {
	var placeholder = "운동명"
    @Binding var isKeyBoardOpen: Bool
    @Binding var searchText: String
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .padding()
            TextField(placeholder,text: $searchText) { inputAble in
                if inputAble {
                    isKeyBoardOpen = true
                }
                else {
                    isKeyBoardOpen = false
                }
            }
            Spacer()
            if searchText != "" {
                Button {
                    self.searchText = ""
                }label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
        .background() {
            RoundedRectangle(cornerRadius:18)
                .foregroundColor(.init(hex: "E2E2E4"))
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(isKeyBoardOpen: .constant(false), searchText: .constant(""))
    }
}
