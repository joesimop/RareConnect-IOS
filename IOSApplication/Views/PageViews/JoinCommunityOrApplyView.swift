//
//  JoinCommunityOrApplyView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import SwiftUI

struct JoinCommunityOrApplyView: View {
    @EnvironmentObject var CommonVM : GeneralVM
    @EnvironmentObject var psUserData : psUserClass
    
    var body: some View {
        VStack(alignment: .leading){
            rcHeadline("Welcome to RareConnect!")
            rcText("We are excited to get you connected to your community. To begin, please submit a request to join a community.")
            
            JoinCommunityView(CommonVM: CommonVM, psUserData: psUserData)
                .navigationBarBackButtonHidden()
            
            HStack{
                rcSubText("Don't see your community?")
                rcNavigationText(dest: ApplyForCommunityView(psUserData: psUserData, CommonVM: CommonVM), text: "Apply to create one.")
            }
            Spacer(minLength: 200)
        }.padding()
    }
}
