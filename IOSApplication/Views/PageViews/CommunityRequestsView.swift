//
//  NoCommunitiesView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/23/24.
//

import SwiftUI
import RxSwift


struct CommunityRequestsView: View {
    
    var CommonVM : GeneralVM
    var psUserData : psUserClass
    @State private var requests : [CommunityRequest] = []
    @State private var hasRequests : Bool = true
    
    var body: some View {
        
        if (hasRequests){
            VStack{
                rcListView(data: requests){ community_request in
                    NavigationLink(destination:
                                    HomeView(community_id: community_request.id)
                                            .navigationBarBackButtonHidden()
                                            .navigationTitle(community_request.name)) {
                        HStack {
                            VStack(alignment: .leading){
                                Text(community_request.name).bold()
                                RequestStatusView(status: community_request.status)
                                TimeElapsedView(prependText: "Submitted request ", suffixText: " ago.", date: community_request.submit_date)
                            }
                            Spacer()
                            
                            if(community_request.status == .Accepted){
                                HStack{
                                    rcText("Home", color: .textSecondary)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white)
                                   }
                                }
                                
                        }
                    }.disabled(community_request.status != .Accepted)
                }
                rcNavigationButton(dest: JoinCommunityView(CommonVM: CommonVM, psUserData: psUserData).navigationTitle("Join Community"), text: "Join another Community")
                Spacer()
            }
            .refreshable {
                fetchCommunityRequests()
            }
            .onAppear {
                fetchCommunityRequests()
            }
        } else {
            JoinCommunityOrApplyView().navigationTitle("")
        }
    }
    
    
    func fetchCommunityRequests(){
        CommonVM.GetCommunityRequests(profile_id: psUserData.id){
            apiResult in
            requests = apiResult
            if (requests.isEmpty) {
                hasRequests = false
            }
        }
    }
}
