//
//  LoginView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/13/23.
//

import Foundation
import SwiftUI



struct LoginView: View {
    
    @EnvironmentObject private var psUserData : psUserClass
    @EnvironmentObject private var psCommunityData : psCommunityClass
    @EnvironmentObject private var CommonVM : GeneralVM
    
    @State private var usernameOrEmail = ""
    @State private var password = ""
    @State private var isEmail = false
    @State private var isForgotPasswordSheetPresented = false
    @State private var loginState = APIResponseCode.NotSent
    
    @ObservedObject var AuthVM : AuthorizationVM
    
    
    var body: some View {
        
        if(!AuthVM.isAuthorized) {
                VStack(alignment: .leading) {

                    rcHeadline("RareConnect\nLogin")

                    Spacer()
                    
                    rcTextInput(prompt: "Username or Email", bindTo: $usernameOrEmail)
                    
                    Spacer()
                    
                    // Password TextField
                    rcSecureField(prompt: "Password", bindTo: $password)
                    
                    Spacer()
                    // Login Button
                    rcButtonSecondary(text: "Login", fillWidth: true) {
                        
                        // Validate inputs before attempting login
                        if isValidInput() {
                            
                            //Loading state
                            loginState = APIResponseCode.Waiting
                            
                            //API Call
                            AuthVM.AuthorizeUser(username: usernameOrEmail, password: password) 
                            { validUsername in
                                AuthVM.SetupApplicationState(username: validUsername, CommonVM: CommonVM, psUserData: psUserData, psCommunityData: psCommunityData)
                            }
                        }
                    }
                    HStack{
                        HStack{
                            HStack{
                                rcSubText("Don't have a profile?").lineLimit(1)
                                rcNavigationText(dest: CreateUserView(psUserData: psUserData, psCommunityData: psCommunityData, CommonVM: CommonVM, AuthVM: AuthVM), text: "Sign Up")
                            }
                            
                            Spacer()
                            
                            HttpStatusView(statusCode: loginState)
                        }
                    }               
                }.padding()
            } else {
                PostLoginViewDecider(CommonVM: CommonVM, psUserData: psUserData, psCommunityData: psCommunityData)
            }
}
    
    // Function to validate inputs
    private func isValidInput() -> Bool {
        
        // Check if both fields are filled out
        guard !usernameOrEmail.isEmpty, !password.isEmpty else {
            return false
        }
        
        // Check if there are no spaces
        guard !usernameOrEmail.contains(" "), !password.contains(" ") else {
            return false
        }
        
        // If the input is an email, validate the email format
        if isEmail {
            return isValidEmail(usernameOrEmail)
        }
        
        return true
    }
}
