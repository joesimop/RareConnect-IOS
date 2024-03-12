//
//  CreateNewPostView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/23/24.
//

import SwiftUI
import AwesomeEnum

struct CreateNewPostView: View {
    
    var profile_id: Int
    var community: psCommunityClass
    var VM: CommunityBoardVM
    var onPostCreated: (APIResponseCode) -> Void
    @State private var text: String = ""
    @State private var isPinnedPost: Bool = false
    @State private var postSuccessful: Bool = false
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: VSTACK_SPACING) {
            rcHeadline("New Post")
            rcTextField(text: $text)
            rcButton(text: "Post", fillWidth: true){
                let newPost = NewBoardPost(profile_id: profile_id, text: text, pinned: isPinnedPost)
                VM.PostToBoard(newPost: newPost){ apiResponse in
                    onPostCreated(apiResponse)
                }
            }
            
            //Only allow the ability to pin posts if user is admin
            if IsAdmin(community.role) {
                Image(uiImage: isPinnedPost ?
                      Awesome.Solid.thumbtack.asImage(size: ICON_SIZE, color: .accent) : Awesome.Solid.thumbtack.asImage(size: ICON_SIZE, color: .black))
                    .onTapGesture {
                        isPinnedPost.toggle()
                    }
                rcText(postSuccessful.description)
            }
            
        }.padding()
    }
}

