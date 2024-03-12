//
//  rcHeadline.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/29/24.
//

import SwiftUI

struct rcHeadline: View {
    var text : String
    
    init(_ text : String){
        self.text = text
    }
    
    
    var body: some View {
        
        Spacer()
        
        Text(text)
            .font(.system(size: 36))
            .fontWeight(.bold)
        
        Spacer()
    }
}
