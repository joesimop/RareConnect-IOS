//
//  Icon.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/16/24.
//

import SwiftUI
import AwesomeEnum


//NOTE: NOT SURE IF I AM USING THIS

struct rcIcon: View {
    
    var icon: Awesome
    var size: CGFloat
    var color: SwiftUI.Color
    
    init(icon: Awesome, size: CGFloat? = nil, color: SwiftUI.Color? = nil){
        self.icon = icon
        self.size = size ?? 20
        self.color = color ?? .black
    }
    
    var body: some View {
        Text("hi")
    }
}
