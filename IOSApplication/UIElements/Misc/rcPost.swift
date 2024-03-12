//
//  Post.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/15/24.
//

import SwiftUI
import AwesomeEnum

//extension AnyTransition {
//    static var moveAndFade: AnyTransition {
//        .asymmetric(
//            insertion: .opacity,
//            removal: .scale.combined(with: .opacity)
//        )
//    }
//}

//Displays a post given a community board post
struct rcPost: View {
    
    @State var post : CommunityBoardPost            // The post to be displayed
    var community : psCommunityClass               // Persistent community data
    var user: psUserClass                         // Persistent user data
    var VM: CommunityBoardVM                      // Injected ViewModel to handle API calls
    var CommentSelectedFunction: (Int) -> Void      // Escaping function to open comment section in parent view
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            //Top line of information (username, favorited)
            HStack(){
                rcText(post.username)
                    .fontWeight(.bold)
                
                Spacer()
                
                rcFavorited(post_id: post.id, profile_id: user.id, favorited: post.favorited, VM: VM, community_id: community.id)
                
            }
            
            //Post content and timestamp
            HStack(alignment: .top){
                rcText(post.text).font(.body)
                Spacer()
                TimeElapsedView(date: post.timestamp)
                    .foregroundColor(.grey)
            }
            
            Divider()
            
            //Oldest three comments
            if !post.comments.isEmpty{
                rcSubText("Comments:")
                
                ForEach(post.comments, id: \.id) { comment in
                    rcComment(comment: comment, indentation: 1, role: community.role, showActions: false)
                }
            } else {
                rcActiveText("Add a comment").onTapGesture {
                    CommentSelectedFunction(post.id)
                }
            }
            
            
            Divider()
            
            //Comment Count, Upvotes and Pinning.
            HStack(spacing: HSTACK_SPACING){
                HStack(spacing: 1) {
                    Image(uiImage: Awesome.Regular.comment.asImage(size: ICON_SIZE))
                    rcSubText("\(post.comment_count)")
                }.onTapGesture {
                    CommentSelectedFunction(post.id)
                }
                
                rcUpVote(post_id: post.id, profile_id: user.id, upvoted: post.upvoted, upvoteCount: post.upvotes, VM: VM, community_id: community.id)
                
                //If admin, allow the post to be pinned
                if IsAdmin(community.role){
                    Spacer()
                    rcPinPost(pinned: post.pinned, post_id: post.id, community_id: community.id, VM: VM)
                }
            }
            
           Divider()
        }
        .padding()
    }
}
