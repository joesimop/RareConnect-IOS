//
//  PostLoginViewDecider.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/26/24.
//

import SwiftUI

struct PostLoginViewDecider: View {

    var CommonVM : GeneralVM
    var psUserData : psUserClass
    var psCommunityData : psCommunityClass
    
    var body : some View{
        
        switch psUserData.profileCommunities.count {
            
        //If profile is not apart of any communities
        case 0:
            CommunityRequestsView(CommonVM: CommonVM, psUserData: psUserData)
                .transition(.opacity)
                .animation(.easeInOut(duration: 100.0),
                           value: true)
                .navigationTitle("Community Requests")
            
            
        //If they are only associated with one community, go straight there.
        case 1:
            SidebarView(psCommunityData: psCommunityData, user: psUserData)
            //SidebarView(psCommunityData: psCommunityData, user: psUserData) {
//                HomeView(community_id: psUserData.profileCommunities[0].id)
//                    .transition(.opacity)
//                    .animation(.easeInOut(duration: 100.0),
//                               value: true)
//                    .navigationTitle(psUserData.profileCommunities[0].name)
            //}
            
        //Allow Selectin the community
        default:
            CommunitySelectView()
                .transition(.opacity)
                .animation(.easeInOut(duration: 100.0),
                           value: true)
                .navigationTitle("Communities")
        }
    }
    
    
}
