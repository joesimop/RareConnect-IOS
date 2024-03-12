//
//  rcConditionalTextInput.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/13/24.
//

import SwiftUI

struct rcConditionalUnderlineOverlay: View {
    
    var color : Color
    
    var body : some View{
        Rectangle().frame(height: 5).padding(.top, 35).foregroundColor(color)
    }
}

struct rcConditionalTextInput: View {
    
    var prompt: String
    var conditionText : String
    @FocusState var isFocused : Bool
    @Binding var bindTo : String
    var validateInput : (String) -> Bool
    
    @State private var isInputValid : Bool = false
    
    private var displayConditionText : Bool { get { !isInputValid && isFocused }}
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            rcSubText(prompt)
            

            TextField("", text: $bindTo)
                .textFieldStyle(rcTextFieldStyle())
                .focused($isFocused)
                .onChange(of: bindTo) { oldValue, newValue in
                    isInputValid = validateInput(newValue)
                }
                .autocapitalization(.none)
                .overlay(rcUnderlineOverlay(underlineColor: determineBorderColor(bindTo)))
                .fontWeight(.bold)
            
            Text(displayConditionText ? conditionText :  "")
                .font(.caption)
                .foregroundColor(Color.error)
                .padding(.top, 10)
            
        }.padding(.bottom, 10)
            .onTapGesture {
                isFocused = true
            }
            .onAppear() {isInputValid = validateInput(prompt)}
    }
        
    
    func determineBorderColor(_ input : String) -> Color {
        if (isFocused)
        {
            if(isInputValid){
                return Color.green
            }
            return Color.red
        }
        return Color.black
    }
}


