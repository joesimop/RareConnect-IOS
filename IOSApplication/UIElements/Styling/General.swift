//
//  General.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 4/5/24.
//

import Foundation
import SwiftUI

struct HorizontalFadeout< V : View> : View {
    
    var content : () -> V
    
    var body: some View {
        ZStack{
            content()
        }.mask(LinearGradient(colors: [.clear, .black], startPoint: .leading, endPoint: .trailing))
    }
}


//MARK: HORIZONTAL GRADIENT FADEOUT
struct HorizontalFadeoutModifier: ViewModifier {
    var fadeWidth: CGFloat = 40 // Default width of the fade effect on each side
    var backgroundColor: Color = .background // Default background color

    func body(content: Content) -> some View {
        content
            .overlay(
                HStack {
                    //LinearGradient(colors: [.white, .clear], startPoint: .leading, endPoint: .trailing).frame(maxWidth: fadeWidth)
                    Spacer()
                    LinearGradient(colors: [.clear, .white], startPoint: .leading, endPoint: .trailing).frame(maxWidth: fadeWidth)
                }
            )
            
    }
}

extension View {
    func horizontalFadeout(fadeWidth: CGFloat = 20, backgroundColor: Color = .white) -> some View {
        modifier(HorizontalFadeoutModifier(fadeWidth: fadeWidth, backgroundColor: backgroundColor))
    }
}
