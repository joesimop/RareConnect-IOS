//
//  rcNavigationText.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import SwiftUI

///Takes user to dest on text press.
struct rcNavigationText<V>: View where V : View{
    
    var dest : V
    var text : String
    
    var body: some View {
        NavigationLink(destination: dest){
            Text(text).font(.system(size: 14))
        }
    }
}
