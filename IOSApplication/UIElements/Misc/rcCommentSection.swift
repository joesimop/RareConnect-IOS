//
//  rcCommentsView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/21/24.
//

import SwiftUI

///Displays the comment section for a post
struct rcCommentSection: View {
    
    var user: psUserClass                           // Persistent user data
    @Binding var post_id: Int                       // Post Identifier
    @ObservedObject var VM: CommunityBoardVM          // Injected ViewModel
    var role: eRole                                // User's role in the community
    @State private var newCommentText: String = ""     // Holds the content
    
    
    var body: some View {
        
        //Comment Seciton Container
        VStack(alignment: .center, spacing: 15) {
            rcText("Comments")
            
            Divider().padding(.horizontal, 10)
            
            //Display list of comments
            APIResultView(apiResult: $VM.commentSection){ comments in
                rcListView(data: comments){ comment in
                    rcComment(comment: comment, indentation: 0, role: role)
                }
            }
            
            //User action, create new comment.
            HStack {
                rcTextInput(prompt: "Add a comment...", bindTo: $newCommentText)
                rcButton(text: "Comment"){
                    let newComment = Comment(username: user.username, profile_id: user.id, post_id: post_id, timestamp: Date.now, text: newCommentText)
                    VM.Comment(newComment: newComment)
                }
            }.padding(.horizontal, 10)
            
            
            Spacer()
           
        }
         .padding(.top, 20)
         .onAppear {
             //Get comments from backend
             VM.GetComments(post_id: post_id)
         }
        
    }
    
}
