//
//  ButtonStyles.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 4/5/24.
//

import Foundation
import SwiftUI

struct BaseButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .foregroundColor(Color.textSecondary)
            .background(.primary1.opacity(
                configuration.isPressed ? 0.8 : 1
            ))
            .cornerRadius(10)
    }
}

struct SliderButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .foregroundColor(Color.textSecondary)
            .background(.primary1.opacity(
                configuration.isPressed ? 0.8 : 1
            ))
            .cornerRadius(10)
    }
}
