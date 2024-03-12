//
//  ProfileView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/1/24.
//

import SwiftUI


struct ProfileView: View {
    
    var community_id: Int
    var profile_id: Int
    @State private var userProfile: ViewResult<UserProfile> = ViewResult.Loading()
    @State private var userCommunities: ViewResult<[AbbrCommunity]> = ViewResult.Loading()
    private var dispatcher: ViewBindAPIDispatcher = ViewBindAPIDispatcher()
    @EnvironmentObject private var CommonVM : GeneralVM
    
    init(community_id: Int, profile_id: Int) {
        self.community_id = community_id
        self.profile_id = profile_id
    }
    
    var body: some View {
        VStack {
            APIResultView(apiResult: $userProfile){ profile in
                VStack{
                    
                    // Profile Image
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    // User Information
                    rcText(profile.firstname + " " + profile.lastname)
                    rcText(profile.username)
                    rcText(profile.email!)
                    HStack{
                        rcText("Been a member since:")
                        TimeElapsedView(date: profile.joined!)
                    }
                    rcRoleView(profile.role!)
                }
            }
            
            Spacer()
            
            APIResultView(apiResult: $userCommunities){ communities in
                rcListView(data: communities){ community in
                    rcText(community.name)
                }
            }
        }.onAppear{
            dispatcher.SendRequests(
                (.getCommunityProfile(community_id: community_id, profile_id: profile_id), $userProfile),
                (.getCommunitiesForProfile(profile_id: profile_id), $userCommunities)
            )
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Action for message button
                }) {
                    Image(systemName: "message")
                }
            }
        }
    }
}
