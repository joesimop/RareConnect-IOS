//
//  rcSubText.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/29/24.
//

import SwiftUI

//Used for small print text and error messages
struct rcSubText: View {
    var text : String
    var isError: Bool
    init(_ text : String, _ isError : Bool? = nil){
        self.text = text
        self.isError = isError ?? false
    }
    
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .foregroundColor(isError ? .error : .grey)
    }
}
