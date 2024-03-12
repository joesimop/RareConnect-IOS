//
//  rcText.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/29/24.
//

import SwiftUI

//Text that can be edited. 
struct rcEditableText: View {
    var text : String
    @Binding var inEditMode : Bool
    
    
    var body: some View {
        Text(text)
        
            .padding()
            .font(.system(size: 14))
            .foregroundColor(!inEditMode ? Color.primary : .background)
            .background(!inEditMode ? .background : Color.primary)
            .cornerRadius(10.0)
    }
}
