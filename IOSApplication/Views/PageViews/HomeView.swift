//
//  HomeView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/13/23.
//

import SwiftUI


struct HomeView: View {
    
    @EnvironmentObject var psCommunityData : psCommunityClass
    @EnvironmentObject var psUserData : psUserClass
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
        //SidebarView(psCommunityData: psCommunityData, user: psUserData) {
            VStack{
                Text("I am home")
                Text("adsf \(psUserData.firstname)")
                Text("Community: \(psCommunityData.name)")
            }
        //}
    }
}
