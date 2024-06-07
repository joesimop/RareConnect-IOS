//
//  rcNavigationButton.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import SwiftUI

///Takes the user to dest on button hit
struct rcNavigationButton<V>: View where V : View {
    
    var dest : V
    var text : String
    
    var body: some View {
        Button(action: {}){
            NavigationLink(destination: dest){
                HStack(spacing: HSTACK_SPACING){
                    Text(text)
                    Image(systemName: "arrow.right")
                }
            }
        }.buttonStyle(SliderButton())
    }
}

