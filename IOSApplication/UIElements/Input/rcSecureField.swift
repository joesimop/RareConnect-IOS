//
//  rcSecureField.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/16/24.
//

import SwiftUI

struct rcSecureField: View {
    
    var prompt: String
    @Binding var bindTo : String
    @FocusState var isFocused : Bool
    
    var body: some View {
            
        VStack(alignment: .leading) {
            
            rcSubText(prompt)

            SecureField("", text: $bindTo)
                .textFieldStyle(rcTextFieldStyle())
                .focused($isFocused)
                .fontWeight(.bold)
                .font(.system(size: 18))
                .overlay(rcUnderlineOverlay(underlineColor: isFocused ? Color.primary1 : Color.textPrimary ))
                
            
        }.onTapGesture {
                isFocused = true
            }
            .padding(.bottom, 30)
            
        
    }
}
