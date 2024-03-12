//
//  CommunityBoardSearchView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/11/24.
//

import SwiftUI

struct CommunityBoardSearchView: View {
    
    var searchPrompt : String
    var community_id: Int
    @State private var request : SearchAPIRequest<[CommunityBoardPostAbbr]>
    
    init(community: psCommunityClass) {
        self.community_id = community.id
        self.request = .searchCommunityBoard(community_id: community_id)
        self.searchPrompt = "Search all posts in the " + community.name + " community."
    }
    
    var body: some View {
        rcDatabaseSearch(request: request, searchPrompt: searchPrompt){ post in
            VStack{
                rcText(post.username)
                rcText(post.text)
            }
        }
    }
}

