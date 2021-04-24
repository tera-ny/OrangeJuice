//
//  BlurButtonStyle.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import Foundation
import SwiftUI

struct BlurButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        let isPressed = configuration.isPressed

        return configuration.label
            .background(
                { () -> Color in
                    isPressed ? Color(.displayP3, red: 209 / 255, green: 209 / 255, blue: 209 / 255, opacity: 0.5) : Color.clear
                }()
                    .clipShape(Circle())
            )
            .scaleEffect(x: isPressed ? 0.9 : 1, y: isPressed ? 0.9 : 1, anchor: .center)
            .animation(.spring(response: 0.2, dampingFraction: 0.9, blendDuration: 0))
    }
}
