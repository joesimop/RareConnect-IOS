//
//  SearchParameterSelectView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/20/24.
//

import SwiftUI

struct SearchParameterSelectView: View {
    let searchParameter: String
    let updateParent: (Bool) -> Void // Escaping closure for search toggle
    @State private var isSelected: Bool = true
    
    var body: some View {
        HStack {
            // Display the string
            Text(searchParameter).font(.system(size: 12))
            
            Spacer()
            
            // Display a check mark or an X based on the selected state
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
        .onTapGesture {
            isSelected.toggle()
            updateParent(isSelected)
        }
    }
}
