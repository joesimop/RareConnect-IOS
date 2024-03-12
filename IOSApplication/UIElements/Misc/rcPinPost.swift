//
//  rcPinPost.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/15/24.
//

import SwiftUI
import AwesomeEnum

///Displays post's pin state. Handles API calling as well.
struct rcPinPost: View {
    
    @State var pinned: Bool      // Pin state
    var post_id: Int            // Post Identifier
    var community_id: Int        // Community Identifier
    var VM: CommunityBoardVM     // Injected ViewModel
    
    
    var body: some View {
        
        //Change display depending on upvote state
        Image(uiImage: pinned ?
              Awesome.Solid.thumbtack.asImage(size: ICON_SIZE, color: .accent) : Awesome.Solid.thumbtack.asImage(size: ICON_SIZE, color: .black))
            .onTapGesture {
                
                //Backend Call
                VM.PinToggle(post_id: post_id){ apiResonse in
                    
                    //Only update frontend if updated in the backend
                    if IsSuccessful(apiResonse) {
                        pinned.toggle()
                    }
                }
                
            }
        
    }
}
