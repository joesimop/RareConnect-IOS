//
//  rcButton.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import SwiftUI

///Displays a button with text as the display text and performs and action.
///Optional Parameters: fillWidth, isLink
///Must define button style in caller.
struct rcButton: View {
    
    var text : String
    var fillWidth : Bool = false
    var isLink : Bool = false
    var action : () -> Void

    init(text: String, fillWidth: Bool? = nil, isLink: Bool? = nil, action: @escaping () -> Void) {
        self.text = text
        self.fillWidth = fillWidth ?? false
        self.isLink = isLink ?? false
        self.action = action
    }
    
    var body: some View {
        Button(action: { self.action() })
        {
            HStack(spacing: HSTACK_SPACING){
                Text(text)
                if isLink {
                    Image(systemName: "arrow.right")
                }
            }
        }.frame(maxWidth: fillWidth ? .infinity : nil)
        //Must define button style on use case
            
    }
}

