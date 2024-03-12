//
//  JoinCommunityView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import SwiftUI

struct JoinCommunityView: View {
    
    var CommonVM : GeneralVM
    var psUserData : psUserClass
    @State private var selectedCommunity : Int = 1
    @State private var message : String = ""
    @State private var submitStatus : APIResponseCode = APIResponseCode.NotSent
    
    var body: some View {
        
        VStack{
            rcCommunitySelectDropdown(selectedCommunity: $selectedCommunity)
            
            rcQuestionPrompt(question: "Write a message to the admin:", response: $message)
            
            rcButton(text: "Submit Request", fillWidth: true) {
                submitStatus = APIResponseCode.Waiting
                CommonVM.SubmitCommunityRequest(
                    community_id: selectedCommunity,
                    request: CommunityRequestBody(profile_id: psUserData.id, message: message), binding: $submitStatus)
            }
            
            switch submitStatus {
            case .Success(_):
                HStack{
                    rcSubText("Your request was successfully sent. To see the status of your request, ")
                    rcNavigationText(dest: CommunityRequestsView(CommonVM: CommonVM, psUserData: psUserData), text: "click here.")
                }
            case .Error(_):
                rcSubText(submitStatus.description, true)
            default:
                EmptyView()
            }
            
        }
        
        
    }
}

