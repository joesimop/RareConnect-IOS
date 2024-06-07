//
//  CommunitySelectView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/23/24.
//

import SwiftUI

struct CommunitySelectView: View {
    
    @EnvironmentObject var AppState : AppStateClass
    
    var body: some View {
        rcListView(data: AppState.user.profileCommunities) { community in
            NavigationLink(destination: SidebarView(psCommunityData: community, user: AppState.user).navigationBarBackButtonHidden())
            {
                HStack {
                    VStack(alignment: .leading) {
                        rcText(community.name, color: .textPrimary)
                        if(community.role == .Admin){
                            rcText("Admin", color: .success).bold()
                        } else {
                            rcText("Member", color: .textPrimary).bold()
                        }
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.textPrimary)
                   }
                }.simultaneousGesture(TapGesture().onEnded{
                    AppState.SetCommunity(newCommunity: community)
                })
            }
        }
    }

