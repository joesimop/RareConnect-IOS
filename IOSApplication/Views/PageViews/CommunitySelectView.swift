//
//  CommunitySelectView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/23/24.
//

import SwiftUI

struct CommunitySelectView: View {
    
    @EnvironmentObject var psUserData : psUserClass
    @EnvironmentObject var psCommunityData : psCommunityClass
    
    var body: some View {
        rcListView(data: psUserData.profileCommunities) { community in
            NavigationLink(destination: SidebarView(psCommunityData: community, user: psUserData).navigationBarBackButtonHidden())
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
                    psCommunityData.SetCommunity(community: community)
                })
            }
        }
    }

