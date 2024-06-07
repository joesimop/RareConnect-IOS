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
    private var isSelf: Bool
    private var dispatcher: ViewBindAPIDispatcher = ViewBindAPIDispatcher()
    
    @EnvironmentObject private var CommonVM : GeneralVM
    @EnvironmentObject private var AuthVM : AuthorizationClass
    @EnvironmentObject private var AppState: AppStateClass
    
    init(community_id: Int, profile_id: Int, isSelf: Bool? = nil) {
        self.community_id = community_id
        self.profile_id = profile_id
        self.isSelf = isSelf ?? false
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
                    rcText(profile.first_name + " " + profile.last_name)
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
                
                if(isSelf){
                    Button(action: {
                        dispatcher.SendRequest(.logout(profile_id: profile_id)){ response in
                            if IsSuccessful(response){
                                DispatchQueue.main.async{
                                    AppState.Logout()
                                    AuthVM.Logout()
                                }
                            } else {
                                print("welp freak")
                            }
                        }
                    }) {
                        rcSubText("Logout")
                    }
                } else {
                    Button(action: {
                        // Action for message button
                    }) {
                        Image(systemName: "message")
                    }
                }
               
            }
        }
    }
}
