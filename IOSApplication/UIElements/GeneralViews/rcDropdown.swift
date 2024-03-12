//
//  rcDropdown.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/9/24.
//

import SwiftUI

struct rcDropdown<ExpandedContent: View>: View {
    
    @State private var isExpanded = false
    @State var headerText: String = "Tap to expand"
    var ExpandedContentView: () -> ExpandedContent

    var body: some View {

        VStack(alignment: .leading) {
            // Header with input field and expand/collapse button
            HStack {
                rcText(headerText).bold()
                Spacer()
                Button(action: {
                    self.isExpanded.toggle()
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
            }.padding()

            // Dropdown content
            if isExpanded {
                // Custom content view that is displayed when expanded
                ExpandedContentView()
                    .padding(.horizontal)
                    .padding(.bottom)
                    .transition(.opacity)
                    .animation(.linear(duration: 0.2),
                               value: isExpanded)
                
            }
        }.background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
            .transition(.slide)
            .animation(.linear(duration: 0.2),
                       value: isExpanded)
    }
}
