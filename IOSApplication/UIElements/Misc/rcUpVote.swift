//
//  rcPostStar.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/15/24.
//

import SwiftUI
import AwesomeEnum

///Displays a profile's upvote state and count of a post. Handles backend calls as well.
struct rcUpVote: View {
    
    var post_id: Int                 // Post identifier
    var profile_id: Int              // Profile Identfier
    @State var upvoted: Bool         // Upvote state
    @State var upvoteCount: Int      // Number of upotes
    var VM: CommunityBoardVM        // Injected ViewModel to perform API calls
    var community_id: Int          // Community Identifier
    
    var body: some View {
        
        //Dynamic Upvote display depending on upvote state
        HStack(spacing: 1) {
            Image( uiImage: upvoted ? Awesome.Solid.arrowAltCircleUp.asImage(size: ICON_SIZE, color: .accent) : Awesome.Regular.arrowAltCircleUp.asImage(size: ICON_SIZE, color: .black))
            
            //Upvote count
            rcSubText("\(upvoteCount)")
        }.onTapGesture {
            
            //Call backend to update upvote state
            let UpvoteState = BooleanToggle(profile_id: profile_id, post_id: post_id, old_bool_state: upvoted)
            VM.UpvoteToggle(body: UpvoteState) { apiResponse in
                
                //Only update UI if the call was successful.
                if IsSuccessful(apiResponse){
                    upvoted.toggle()
                    upvoteCount = upvoted ? upvoteCount + 1 : upvoteCount - 1
                }
            }
            
        }
    }
}
