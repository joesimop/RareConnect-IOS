//
//  rcSelectableListItem.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/23/24.
//

import SwiftUI

//NOTE: NOT SURE IF I AM USING THIS

struct rcSelectableListItem: View {
    
    var LeftText : String
    var RightText : String
    
    var body: some View {
        HStack {
            Text(LeftText).bold()

               Spacer() // Push additional info to the right

               Text(RightText)
    
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
           }

           
        
    }
}
