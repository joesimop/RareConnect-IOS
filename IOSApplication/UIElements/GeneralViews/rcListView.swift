//
//  rcListView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/24/24.
//

import SwiftUI


//Base List Item look
struct ListItem<Content: View>: View {
    var content: () -> Content

    var body: some View {
        content()
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Match corner radius with the view
                    .stroke(Color.black, lineWidth: 2) // Apply stroke as border
             )
            .foregroundColor(.black)
            .background(Color.white)
    }
}

///Displays a list from the given data
struct rcListView<V : View, T : Hashable>: View {

    var data : [T]                      //Data to display in the list
    var ImplementedListItem : (T) -> V    //How to display it
    
    var body : some View {
        
        ScrollView{
            LazyVStack(alignment: .leading, spacing: 15.0){
                ForEach(data, id: \.self) { item in
                    ListItem { ImplementedListItem(item) }
                }
            }.padding()
        }
        
        
        
    }
   
}
