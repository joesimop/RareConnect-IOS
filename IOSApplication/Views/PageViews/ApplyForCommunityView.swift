//
//  ApplyForCommunityView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import SwiftUI
import RxSwift


struct ApplyForCommunityView: View {
    
    var psUserData : psUserClass
    var CommonVM : GeneralVM
    
    @State private var phoneNumber: String = "+1 (916) 462-2214"
    @State private var professionalEmail: String = "joesimop8@gmail.com"
    @State private var organizationName: String = "WDA"
    @State private var answer1: String = "often"
    @State private var answer2: String = "very much so"
    @State private var message: String = "a message"
    @State private var submitStatus : APIResponseCode = APIResponseCode.NotSent
    
//    @State private var phoneNumber: String = ""
//    @State private var professionalEmail: String = ""
//    @State private var organizationName: String = ""
//    @State private var answer1: String = ""
//    @State private var answer2: String = ""
//    @State private var message: String = ""
//    @State private var submitStatus : APIResponseCode = APIResponseCode.NotSent

        var body: some View {
                //rcPageHeader("Apply to create a community")
                rcSlideView(views:
                [
                    rcSlideViewItem{
                        VStack{
                            rcConditionalTextInput(prompt: "Professional Email", conditionText: "Must be a valid email", bindTo: $professionalEmail, validateInput: isValidEmail)
                            
                            rcPhoneInput(bindTo: $phoneNumber)
                            
                            rcTextInput(prompt: "Organization Name", bindTo: $organizationName)
                        }
                    },
                    rcSlideViewItem{
                        VStack{
                            rcQuestionPrompt(question: "How often do you interact with other members of your community?",
                                response: $answer1)
                        }
                    },
                    rcSlideViewItem{
                        VStack{
                            rcQuestionPrompt(question: "How do you see our services benefiting you?",
                                response: $answer2)
                        }
                    },
                    rcSlideViewItem{
                        VStack{
                            rcQuestionPrompt(question: "Personal message to RareConnect:",
                                             response: $message)
                            
                            rcButtonSecondary(text: ("Submit Application"), fillWidth: true) {
                                // Create the JSON object with the entered values
                                let application = CommunityApplicationBody(
                                    profile_id: psUserData.id,
                                    phone_number: phoneNumber,
                                    professional_email: professionalEmail,
                                    organization_name: organizationName,
                                    answer1: answer1,
                                    answer2: answer2,
                                    message: message)
                                
                                CommonVM.SubmitCommunityApplication(application: application, response: $submitStatus)
                                
                            }
                            
                            HttpStatusView(statusCode: submitStatus)
                            
                            
                        }
                    },
                ]).navigationTitle("Community Application")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(){
                    
                }
        }
    }
