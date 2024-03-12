//
//  rcTextLarge.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/29/24.
//

import SwiftUI

//Large text
struct rcTextLarge: View {
    var text : String
    
    init(_ text : String){
        self.text = text
    }
    
    
    var body: some View {
        Text(text)
            .font(.system(size: 22))
            .foregroundColor(.textPrimary)
    }
}
