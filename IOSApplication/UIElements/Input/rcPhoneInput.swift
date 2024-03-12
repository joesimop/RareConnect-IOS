//
//  rcPhoneInput.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/27/24.
//

import SwiftUI
import iPhoneNumberField

struct rcPhoneInput: View {
    
    @Binding var bindTo : String
    @FocusState var isFocused : Bool
    
    var body : some View {
        
        VStack(alignment: .leading) {
            
            rcSubText("Phone Number")
            
            iPhoneNumberField(text: $bindTo)
                .flagHidden(false)
                .prefixHidden(false)
                .countryCodePlaceholderColor(Color.gray)
                .numberPlaceholderColor(Color.gray)
                .autofillPrefix(true)
                .formatted()
                .maximumDigits(10)
                .placeholderColor(Color.gray)
                .focused($isFocused)
                .overlay(rcUnderlineOverlay(underlineColor: isFocused ? Color.primary1 : Color.textPrimary))
                .fontWeight(.bold)
            
        }.padding(.bottom, 30)
        
        
    }
    
    
}
