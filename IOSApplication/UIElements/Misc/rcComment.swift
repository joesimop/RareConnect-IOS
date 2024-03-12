//
//  rcComment.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/15/24.
//

import SwiftUI
import AwesomeEnum

///Displays a comment on a post
struct rcComment: View {
    
    var comment: Comment             //The comment data itself
    var indentation: CGFloat         //How indented the comment is
    var role : eRole               //User's role, affects if admin functionality is displayed
    var showActions: Bool = true    //Whether or not to display the admin functionality
    
    var body: some View {
        
        //Comment Data
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top){
                rcText(comment.username!)
                    .fontWeight(.bold)
                rcText(comment.text)
                Spacer()
                TimeElapsedView(date: comment.timestamp)
                    .foregroundColor(.grey)
            }
            
            //Reply or Hide comment
            if showActions {
                HStack(spacing: 10){
                    Text("Reply")
                        .font(.caption)
                        .foregroundColor(.grey)
                    if IsAdmin(role) {
                        Text("Hide Comment")
                            .font(.caption)
                            .foregroundColor(.grey)
                    }
                }
            }
            
        }
        .padding(.leading, indentation * 20)
    }
}
