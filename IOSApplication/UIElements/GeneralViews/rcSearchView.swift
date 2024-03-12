//
//  rcSearchView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/18/24.
//

import SwiftUI

///A view to search objects already popoulated in the frontend.
struct rcSearchView<ItemType : Hashable, itemView: View> : View {
    
    @State private var searchText: String = ""              // Holds the currently searched text
    private var searchPrompt: String                       // Placeholder text in searchbar
    private var items: [ItemType]
    @Binding private var isSearching: Bool                  // Exposed state so the parent view knows if something is being searched
    private let resultView: (ItemType) -> itemView        // How an individual item is displayed
    private let searchFields : [(ItemType) -> String]      // Which fields inside the object that are searched
    


    init(items: [ItemType], searchPrompt: String? = nil, searchFields: [(ItemType) -> String], isSearching: Binding<Bool>, @ViewBuilder resultView: @escaping (ItemType) -> itemView) {
        self.items = items
        self.searchPrompt = searchPrompt ?? "Search"
        self.searchFields = searchFields
        self.resultView = resultView
        self._isSearching = isSearching
    }
    
    var filteredResults : [ItemType] {
        
        //Show items if nothing searched
        if searchText.isEmpty {
            return items
        } else {
            
            //Filter items based on the passed search fields
            return items.filter { item in
                searchFields.contains { field in
                    field(item).localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }

    var body: some View {
        
        //Display the search items
        LazyVStack(alignment: .leading){
            ForEach(filteredResults, id: \.self) { item in
                ListItem { resultView(item) }
            }
        }.searchable(text: $searchText, isPresented: $isSearching, placement: .toolbar, prompt: searchPrompt)
        
    }
}


