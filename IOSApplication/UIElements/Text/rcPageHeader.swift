//
//  rcPageHeader.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/28/24.
//

import SwiftUI

struct rcPageHeader: View {
    
    var text : String
    
    init(_ text : String){
        self.text = text
    }
    
    
    var body: some View {
        Text(text)
            .font(.system(size: 28))
            .fontWeight(.bold)
    }
}
