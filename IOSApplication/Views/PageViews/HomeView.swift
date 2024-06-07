//
//  HomeView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/13/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var AppState : AppStateClass
    var community_id : Int
    
    //By passing the Community Into the view, we are able to dispatch API Reqeusts faster rather
    //than waiting for the view to render and then pulling from the enviroment object
    init(community_id : Int){
        self.community_id = community_id
    }
    
    init(community : AbbrCommunity) {
        self.community_id = community.id
    }
    
    init(community: psCommunityClass) {
        self.community_id = community.AsAbbrCommunity().id
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: VSTACK_SPACING){
            rcHeadline(AppState.community.name).padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: HSTACK_SPACING) {
                    Spacer()
                    rcNavigationButton(dest: CommunityGuidelinesView(community: AppState.community, profile_id: AppState.user.id), text: "Guidelines")
                    rcNavigationButton(dest: DonationView(community_id: AppState.community.id, profile_id: AppState.user.id, role: AppState.community.role), text: "Donate")
                    rcNavigationButton(dest: CommunityBoardView(user: AppState.user, psCommunityData: AppState.community), text: "Board")
                    rcNavigationButton(dest: PeopleView(community: AppState.community), text: "People")
                    rcNavigationButton(dest: FAQView(community: AppState.community, profile_id: AppState.user.id), text: "FAQs")
                    Spacer()
                }
            }
            Spacer()
        }.padding(.top, 5)
    }
}
