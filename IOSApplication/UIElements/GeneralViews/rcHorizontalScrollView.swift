//
//  SwiftUIView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/15/24.
//

import SwiftUI

///Displays the objects in data in a horizontal scroll view, with itemView telling how to display them
struct rcHorizontalScrollView<Item : View, T : Hashable>: View {
    
    @State var data: [T]                //Data to display
    var itemView: (T) -> Item           //How to display the data
    var spacing: CGFloat?                //Spacing between each item
    var matchMaxWidth: Bool              //Whether to fully expand itself
    var showScrollbar: Bool              //Whether to show scrollbar
      
    init(data: [T], spacing: CGFloat? = nil, matchMaxWidth: Bool? = nil, showScrollbar: Bool? = nil, item: @escaping (T) -> Item) {
        self.data = data
        self.itemView = item
        self.spacing = spacing ?? 10
        self.matchMaxWidth = matchMaxWidth ?? true
        self.showScrollbar = showScrollbar ?? true
    }
      
    var body: some View {
        ScrollView(.horizontal, showsIndicators: showScrollbar) {
            HStack(spacing: spacing) {
                ForEach(data, id: \.self) { item in
                    itemView(item)
                }
            }
        }.horizontalFadeout()
    }
}
