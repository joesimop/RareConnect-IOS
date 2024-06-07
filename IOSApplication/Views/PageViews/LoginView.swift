//
//  LoginView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/13/23.
//

import Foundation
import SwiftUI



struct LoginView: View {
    
    //Passing is faster than Environment Objects
    var AppState : AppStateClass
    var AuthVM : AuthorizationClass
    var CommonVM : GeneralVM
    
    @State private var usernameOrEmail = ""
    @State private var password = ""
    @State private var isEmail = false
    @State private var isForgotPasswordSheetPresented = false
    @State private var loginState = APIResponseCode.NotSent
    
    
    
    
    var body: some View {
        
    
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
                        AuthVM.AuthorizeUser(username: usernameOrEmail, password: password, resultBinding: $loginState)
                        { authorizedUsername in
                            AppState.SetupApplicationState(username: authorizedUsername){
                                AuthVM.ManualAuthorizationValidated()
                            }
                        }
                    }
                }
                HStack{
                    HStack{
                        HStack{
                            rcSubText("Don't have a profile?").lineLimit(1)
                            rcNavigationText(dest: CreateUserView(AppState: AppState, AuthVM: AuthVM, CommonVM: CommonVM), text: "Sign Up")
                        }
                        
                        Spacer()
                        
                        HttpStatusView(statusCode: loginState)
                    }
                }
            }.padding()
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
