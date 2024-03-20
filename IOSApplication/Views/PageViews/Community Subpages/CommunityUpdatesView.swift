//
//  CommunityUpdatesView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/16/24.
//

import SwiftUI

struct CommunityUpdatesView: View {
    
    var user: psUserClass
    var community : psCommunityClass
    private var role : eRole
    @State var isSearching : Bool = false
    @State var createArticlePresented : Bool = false
    @StateObject private var VM : CommunityUpdatesVM
    
    init(user: psUserClass, psCommunityData: psCommunityClass) {
        self.user = user
        self.community = psCommunityData
        self.role = psCommunityData.role
        self._VM = StateObject(wrappedValue: CommunityUpdatesVM(community_id: psCommunityData.id, profile_id: user.id))
    }
    
    var body: some View {
        ScrollView{
            APIResultView(apiResult: $VM.communityUpdates){ updates in
                rcSearchView(items: updates, searchPrompt: "Search Community Updates", searchFields: [{$0.title}, {$0.abstract}], isSearching: $isSearching){ article in
                    NavigationLink(destination: ArticleView(community_id: community.id, article_id: article.id)
                        .navigationTitle(article.title)) {
                            VStack(alignment: .leading, spacing: 10.0){
                                HStack(alignment: .center, spacing: 10.0){
                                    VStack(alignment: .leading, spacing: 2.0){
                                        rcText(article.title).bold()
                                        rcSubText(article.timestamp.formatted())
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.textPrimary)
                                }
                                rcText(article.abstract).multilineTextAlignment(.leading)
                            }
                        }
                }
            }
            Spacer()
        }.refreshable {
            VM.Refresh()
        }.toolbar{
            if IsAdmin(self.role){
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        createArticlePresented.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }.sheet(isPresented: $createArticlePresented){
            CreateArticleView()
        }
    }
}
