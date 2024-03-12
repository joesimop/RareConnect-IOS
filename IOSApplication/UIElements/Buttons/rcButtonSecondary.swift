//
//  rcButtonSecondary.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import SwiftUI

struct rcButtonSecondary: View {
    var text : String
    var fillWidth : Bool = false
    var action : () -> Void

    init(text: String, fillWidth: Bool? = nil, action: @escaping () -> Void) {
        self.text = text
        self.fillWidth = fillWidth ?? false
        self.action = action
    }
    
    var body: some View {
        Button(action: { self.action() })
        {
           Text(text)
                .bold()
               .foregroundColor(Color.textSecondary)
               .padding(.vertical, 15)
               .padding(.horizontal, 20)
               .frame(maxWidth: fillWidth ? .infinity : 90)
                       
        }.background(.accent)
            .cornerRadius(8)
    }
}
