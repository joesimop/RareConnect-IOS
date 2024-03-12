//
//  rcTextInput.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/13/24.
//

import SwiftUI


struct rcTextFieldStyle: TextFieldStyle {
    
    @FocusState var isFocused : Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.leading, 10)
            .focused($isFocused)
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
}

struct rcUnderlineOverlay: View {
    
    var underlineColor : Color
    
    var body : some View{
        Rectangle().frame(height: 5)
            .foregroundColor(underlineColor)
            .padding(.top, 40)
    }
}

struct rcTextInput: View {
    
    var prompt: String
    @Binding var bindTo : String
    @FocusState var isFocused : Bool

    var body: some View {
        
        VStack(alignment: .leading) {
            
            rcSubText(prompt)

            TextField("", text: $bindTo)
                .textFieldStyle(rcTextFieldStyle())
                .focused($isFocused)
                .fontWeight(.bold)
                .font(.system(size: 14))
                .overlay(rcUnderlineOverlay(underlineColor: defaultUnderlineColor()))
            
        }.onTapGesture {
                isFocused = true
        }.padding(.bottom, 30)
        
    }
    
    func defaultUnderlineColor() -> Color {
        return isFocused ? Color.primary1 : Color.textPrimary
    }
}

