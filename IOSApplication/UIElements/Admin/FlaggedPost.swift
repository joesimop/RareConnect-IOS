//
//  FlaggedPost.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 5/20/24.
//

import SwiftUI

struct FlaggedPost: View {
    
    var Post : AdminNotification
    var VM : AdminVM
    
    var body: some View {
        VStack(alignment: .leading){
            
            rcText("The follwoing post was flagged for possibly irrelevant content:").bold()
            
            VStack(alignment: .center){
                    rcText(Post.text)
            }.padding(.leading)
                .padding(.vertical)
            HStack{
                rcText("This was posted")
                TimeElapsedView(date: Post.timestamp)
                rcText("ago.")
            }
            rcText("Please permit the post or deny it.").bold()
            
            HStack{
                Button("Permit"){
                    VM.AllowPost(notification_id: Post.id, allow_post: true)
                }.border(.success)
                    .foregroundColor(.success)
                Button("Deny"){
                    VM.AllowPost(notification_id: Post.id, allow_post: false)
                }.border(.error)
                    .foregroundColor(.error)
            }
        }
        
    }
}

