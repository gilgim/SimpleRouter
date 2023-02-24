//
//  SearchBarView.swift
//  Router
//
//  Created by Gaea on 2023/02/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .padding()
            TextField("운동명",text: $searchText)
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
                .foregroundColor(.gray.opacity(0.2))
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
