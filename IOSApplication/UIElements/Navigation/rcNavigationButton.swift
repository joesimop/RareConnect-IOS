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
    @State private var isActive : Bool = false
    
    var body: some View {
        NavigationLink(destination: dest, isActive: $isActive){
            rcButton(text: text, fillWidth: true) { isActive = true }
        }
    }
}

