//
//  PinnedPost.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/23/24.
//

import SwiftUI
import AwesomeEnum

///Displays a view of pinned posts t in the horizontal scroll bar at the top of Community Board page.
struct rcPinnedPost: View {
    
    @State var post : CommunityBoardPost            // The Post data
    var community : psCommunityClass               // Persistent Community data
    var user: psUserClass                         // Persistent User Data
    var VM: CommunityBoardVM                      // Injected ViewModel for API calls
    var CommentSelectedFunction: (Int) -> Void      // Escaping function to open comment section in parent view
    
    var body: some View {
        
        //SAME AS rcPost WITHOUT THE COMMENTS
        VStack(alignment: .leading, spacing: 10) {
            
            HStack(){
                rcText(post.username)
                    .fontWeight(.bold)
                
                Spacer()
                
                rcFavorited(post_id: post.id, profile_id: user.id, favorited: post.favorited, VM: VM, community_id: community.id)
                
            }
            
            HStack{
                rcText(post.text)
                    .font(.body)
                Spacer()
                TimeElapsedView(date: post.timestamp)
                    .foregroundColor(.grey)
            }

            Divider()
            HStack(spacing: HSTACK_SPACING){
                HStack(spacing: 1) {
                    Image(uiImage: Awesome.Regular.comment.asImage(size: ICON_SIZE))
                    rcSubText("\(post.comment_count)")
                }.onTapGesture {
                    CommentSelectedFunction(post.id)
                }
               
                rcUpVote(post_id: post.id, profile_id: user.id, upvoted: post.upvoted, upvoteCount: post.upvotes, VM: VM, community_id: community.id)
                if IsAdmin(community.role){
                    Spacer()
                    rcPinPost(pinned: post.pinned, post_id: post.id, community_id: community.id, VM: VM)
                }
            }
            
           
        }.frame(maxWidth: 250)
        .padding()
    }
}
