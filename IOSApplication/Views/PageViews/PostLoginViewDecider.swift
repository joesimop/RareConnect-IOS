//
//  PostLoginViewDecider.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/26/24.
//

import SwiftUI

struct PostLoginViewDecider: View {

    var AppState : AppStateClass
    var CommonVM : GeneralVM
    
    
    var body : some View{
        
        switch AppState.user.profileCommunities.count {
            
        //If profile is not apart of any communities
        case 0:
            CommunityRequestsView(CommonVM: CommonVM, psUserData: AppState.user)
                .transition(.opacity)
                .animation(.easeInOut(duration: 100.0),
                           value: true)
                .navigationTitle("Community Requests")
            
            
        //If they are only associated with one community, go straight there.
        case 1:
            SidebarView(psCommunityData: AppState.community, user: AppState.user)

            
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
