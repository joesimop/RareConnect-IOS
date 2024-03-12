//
//  rcDatabaseSearch.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/28/24.
//

import SwiftUI

///Performs a database search of a given search request and returns the items in a viewable list
struct rcDatabaseSearch<T : Decodable & Hashable, itemView: View>: View {
    
    var searchPrompt: String = "Search"                //Placeholder search text
    @State private var searchText: String = ""          // Holds the currently searched string
    @State private var results: [T] = []              // The results of the database search
    //@Binding private var isSearching: Bool                  // Exposed state so the parent view knows if something is being searched
    private var VM : SearchViewModel<T>                // ViewModel that takes care of the backend calling
    private var content: (T) -> itemView              // How an individual result is displayed
    
    
    ///Takes in the specific search request and how to display the returned items.
    init(request: SearchAPIRequest<[T]>, /*isSearching: Binding<Bool>,*/ searchPrompt: String? = nil, content: @escaping (T) -> itemView) {
        self.VM = SearchViewModel(request: request)
        self.content = content
        self.searchPrompt = searchPrompt ?? "Search"
       // self._isSearching = isSearching
    }
    
    var body: some View {
        
        //Display the items
        VStack{
            rcListView(data: results) { result in
                content(result)
            }
        }
        .searchable(text: $searchText,/* isPresented: $isSearching,*/ placement: .navigationBarDrawer(displayMode: .always), prompt: searchPrompt)
        .onChange(of: searchText){oldInput, newInput in
            //Query Backend
            VM.search(newQuery: newInput)
        }.onAppear{
            //If we have results cached already,
            //we do not want to bind to the VM again or send another request.
            if(results.isEmpty) {
                self.VM.bindTo($results)                // Bind VM to the results, maybe look into publishing but this is fine for now
                self.VM.search(newQuery: searchText)     // Query backend
            }
        }
    }
}
