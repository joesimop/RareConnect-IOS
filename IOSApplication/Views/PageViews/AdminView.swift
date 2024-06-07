//
//  AdminView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 5/20/24.
//

import SwiftUI

struct AdminView: View {
    
    private var community_id = 0
    private var profile_id = 0
    @StateObject private var VM = AdminVM()
    
    init(community_id: Int, profile_id: Int) {
        self.community_id = community_id
        self.profile_id = profile_id
    }
    
    
    var body: some View {
        APIResultView(apiResult: $VM.Notifications) { notifications in
            rcListView(data: notifications){ notification in
                VStack{
                    switch(notification.type){
                    case .JoinRequest:
                        rcText("Join")
                    case .FlaggedPost:
                        FlaggedPost(Post: notification, VM: VM)
                    case .MemberJoined:
                        rcText("Member Joined")
                    }
                }
            }
        }.refreshable {
            VM.Refresh()
        }.onAppear(){
            VM.Initialize(community_id: community_id, profile_id: profile_id)
        }
    }
}
