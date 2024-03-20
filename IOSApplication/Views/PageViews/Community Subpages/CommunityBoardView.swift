//
//  CommunityBoardView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/15/24.
//

import SwiftUI

struct CommunityBoardView: View {
    
    var user: psUserClass
    var community : psCommunityClass
    
    @State var showCommentSection: Bool = false
    @State private var commentSectionId: Int = -1
    @State private var isSearching: Bool = false
    @State private var createPostPresented: Bool = false
    @StateObject private var VM : CommunityBoardVM
    
    init(user: psUserClass, psCommunityData: psCommunityClass) {
        self.user = user
        self.community = psCommunityData
        self._VM = StateObject(wrappedValue: CommunityBoardVM(community_id: psCommunityData.id, profile_id: user.id))
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                
                //Hide pinned posts while searching
                if !isSearching {
                    rcTextLarge("Pinned Posts").bold()
                    APIResultView(apiResult: $VM.pinnedPosts){ pinnedPosts in
                        rcHorizontalScrollView(data: pinnedPosts){ post in
                            rcPinnedPost(post: post, community: community, user: user, VM: VM)
                            { selectedPost in
                                commentSectionId = selectedPost
                                showCommentSection = true
                            }
                        }
                    }
                }
                
                
                rcTextLarge("All Posts").bold()
                ///Allow user to search posts
                APIResultView(apiResult: $VM.posts){ posts in
                    rcSearchView(items: posts, searchPrompt: "Search Posts", searchFields: [{$0.text}, {$0.username}], isSearching: $isSearching)
                    
                    ///Instantiate each post view
                    ///When a comment section of a post is clicked, update the parent view to display the comment section
                    { post in rcPost(post: post, community: community, user: user, VM: VM)
                        { selectedPost in
                            commentSectionId = selectedPost
                            showCommentSection = true
                        }
                    }
                }
            }.padding()
            
        ///Pull new posts on refresh
        }.refreshable {
            VM.Refresh()
            
        ///Comment Section Popover
            ///Might be worth passing a reference of the post's comments then just adding to that. For now, the escaping closure is okay.
        }.popover(isPresented: $showCommentSection, arrowEdge: .bottom) {
            rcCommentSection(user: user, post_id: $commentSectionId, VM: VM, role: community.role)
            .presentationDetents([.fraction(2/3)])
            .presentationDragIndicator(.visible)
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: CommunityBoardSearchView(community: community)
                    .navigationTitle("Search All Posts")){
                    Image(systemName: "magnifyingglass")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    createPostPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .popover(isPresented: $createPostPresented, content: {
            CreateNewPostView(profile_id: user.id, community: community, VM: VM){ apiResponse in
                if IsSuccessful(apiResponse){
                    createPostPresented = false
                }
            }
        })
       
    }
}

