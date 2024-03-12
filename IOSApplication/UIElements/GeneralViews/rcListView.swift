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
            .cornerRadius(8)
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
            LazyVStack(alignment: .leading){
                ForEach(data, id: \.self) { item in
                    ListItem { ImplementedListItem(item) }
                        .cornerRadius(8)
                }
            }.padding()
        }
        
        
        
    }
   
}
