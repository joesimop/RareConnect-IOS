//
//  rcActiveText.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/15/24.
//

import SwiftUI

//Text that indicates that an object is currently selected
struct rcActiveText: View {
    var text : String
    
    init(_ text : String){
        self.text = text
    }
    
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .underline()
            .foregroundColor(.accent)
    }
}
