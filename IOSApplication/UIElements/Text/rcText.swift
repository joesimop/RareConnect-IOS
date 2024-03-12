//
//  rcText.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/29/24.
//

import SwiftUI

//Body text
struct rcText: View {
    var text : String
    var color : Color
    
    init(_ text: String, color: Color? = nil){
        self.text = text
        self.color = color ?? .textPrimary
    }
    
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .foregroundColor(color)
    }
}
