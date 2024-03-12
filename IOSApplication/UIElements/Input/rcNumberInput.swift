//
//  rcNumberInput.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/13/24.
//

import SwiftUI

struct rcNumberInput: View {
    
    var prompt: String
    @Binding var bindTo : String
    
    var body: some View {
        rcTextInput(prompt: prompt, bindTo: $bindTo)
            .keyboardType(.numberPad)
    }
}


