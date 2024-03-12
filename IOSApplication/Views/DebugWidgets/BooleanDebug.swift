//
//  BooleanDebug.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/10/24.
//

import SwiftUI

struct BooleanDebug: View {
    
    let BoolState : Bool;
    let label : String;
    
    var body: some View {
        HStack{
            Text(label + ": ")
            switch BoolState{
            case false:
                Text(BoolState.description)
                    .foregroundStyle(Color.red)
            case true:
                Text(BoolState.description)
                    .foregroundStyle(Color.green)
            }
            
        }
    }
}
