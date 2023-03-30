//
//  Extension.swift
//  Router
//
//  Created by Gaea on 2023/02/24.
//

import Foundation
import SwiftUI
//  MARK: - Color
extension Color {
    /**
     Hex code를 입력하면 RGB 컬러로 바꿔줍니다.
     -  parameters:
        -   hex: 헥사코드를 입력합니다.
     */
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }
            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue:  Double(b) / 255,
                opacity: Double(a) / 255
            )
        }
}

extension View {
    @ViewBuilder func isHidden(_ state: Bool) -> some View {
        if state {
            self.hidden()
        }
        else {
            self
        }
    }
    @ViewBuilder func customTapGesture(isTapAble: Bool, _ closure: @escaping () -> ()) -> some View {
        if isTapAble {
            self.onTapGesture {
                closure()
            }
        }
        else {
            self
        }
    }
    @ViewBuilder func customSwipeAction(isSwipeAble: Bool, @ViewBuilder _ content: @escaping () -> some View) -> some View {
        if isSwipeAble {
            self.swipeActions {
                content()
            }
        }
        else {
            self
        }
    }
}
