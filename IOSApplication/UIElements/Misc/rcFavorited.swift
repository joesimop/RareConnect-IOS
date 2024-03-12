//
//  rcFavorited.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/22/24.
//

import SwiftUI
import AwesomeEnum

///Displays a profile's favorite state of a post. Handles API toggling internally.
struct rcFavorited: View {
    
    var post_id: Int                //Post Identifier
    var profile_id: Int             // Profile Identifier
    @State var favorited: Bool       // Favorited State
    var VM: CommunityBoardVM         // Injected ViewModel for API calling
    var community_id: Int            // Community Identifier
    
    var body: some View {
        
        //Change display depending on favorite state
        Image( uiImage: favorited ? Awesome.Solid.star.asImage(size: 20, color: .accent) : Awesome.Regular.star.asImage(size: 20, color: .black))
            .onTapGesture {
                
                //Backend Toggle
                let FavoriteState = BooleanToggle(profile_id: profile_id, post_id: post_id, old_bool_state: favorited)
                VM.FavoriteToggle(body: FavoriteState) { apiResponse in
                    
                    //Only update if the toggle was successful
                    if IsSuccessful(apiResponse){
                        favorited.toggle()
                    }
                }
            }
    }
}
