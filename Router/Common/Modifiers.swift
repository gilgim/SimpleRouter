//
//  Modifiers.swift
//  Router
//
//  Created by Gaea on 2023/02/24.
//

import Foundation
import SwiftUI

//  MARK: RoundedRectangleModifier
struct RoundedRectangleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background() {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray.opacity(0.2))
            }
    }
}
struct KeyboardHideModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
