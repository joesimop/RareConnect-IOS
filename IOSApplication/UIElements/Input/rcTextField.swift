//
//  rcTextField.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/14/24.
//

import SwiftUI

struct rcTextField: View {
    
    
    @Binding var text: String
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack{
                TextEditor(text: $text)
                    .cornerRadius(15)
                    .background(Color.background)
                    .foregroundColor(Color.black)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.grey, lineWidth: 1)
                
            }
        }
    }
}
