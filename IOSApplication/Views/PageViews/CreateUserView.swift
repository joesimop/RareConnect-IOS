//
//  CreateUserView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/13/23.
//

import Foundation
import SwiftUI



struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
            )
            .textFieldStyle(PlainTextFieldStyle())
    }
}

struct CreateUserView: View {
    
    //Passing in as variables, better than using @EnviromentObject
    var psUserData : psUserClass
    var psCommunityData : psCommunityClass
    var CommonVM : GeneralVM
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var passwordConfirmation = ""
    @State private var email = ""
    @State private var isEmailValid = false
    @State private var age = ""
    @State private var selectedGender = eGender.Male
    @State private var address = ""
    @State private var residingCity = ""
    @State private var hasSubmittedNewUser : Bool = false;
    @State private var createdUserState  = APIResponseCode.NotSent
    
    @ObservedObject var AuthVM : AuthorizationVM

    var body: some View {
        
        if(!AuthVM.isAuthorized){
            VStack(alignment: .leading) {
                
                rcHeadline("Create Profile")
                
                rcSlideView(views:
                [
                    rcSlideViewItem{
                        VStack{
                            rcConditionalTextInput(prompt: "First Name", conditionText: "Field must be filled.", bindTo: $firstName) { _ in !firstName.isEmpty}
                            rcConditionalTextInput(prompt: "Last Name", conditionText: "Field must be filled.", bindTo: $lastName) { _ in !lastName.isEmpty}
                            
                        }
                    },
                    rcSlideViewItem {
                        VStack{
                            rcConditionalTextInput(prompt: "Username", conditionText: "Field must be filled.", bindTo: $username) { _ in !username.isEmpty }
                            
                            rcConditionalTextInput(prompt: "Email", conditionText: "Must be a valid email", bindTo: $email, validateInput: isValidEmail)
                        }
                    },
                    rcSlideViewItem {
                        VStack{
                            rcConditionalTextInput(prompt: "Password", conditionText: "Must contain at least 3 characters, a number, and !@#$%^&*", bindTo: $password, validateInput: isValidPassword)
                            
                            rcConditionalTextInput(prompt: "Password Confirmation", conditionText: "Passwords must match", bindTo: $passwordConfirmation) { _ in password == passwordConfirmation }
                        }
                        
                        
                    },
                    rcSlideViewItem {
                            HStack {
                                rcTextInput(prompt: "Residing City", bindTo: $residingCity)
                                rcDropdownSelect<eGender>(selectedOption: $selectedGender)
                            }
                        
                    }
                    
                ])
                HStack {
                    rcButtonSecondary(text: "Sign Up", fillWidth: true) {
                        // Perform verification and signup logic here
                        if isValidInput() {
                            let newUser =
                            UserProfileCreation(
                                id: 0,              ///Value is not used, just to keep JSON format consistent.
                                firstname: firstName,
                                lastname: lastName,
                                username: username,
                                password: passwordConfirmation,
                                email: email,
                                age: "10",
                                gender: selectedGender,
                                residingCity: residingCity
                            )
                            hasSubmittedNewUser = true
                            
                            //LoadState
                            createdUserState = APIResponseCode.Waiting
                            
                            //Submit create user and store in user defaults if successful
                            AuthVM.CreateUser(newUser: newUser){ validUsername in
                                AuthVM.SetupApplicationState(username: validUsername, CommonVM: CommonVM, psUserData: psUserData, psCommunityData: psCommunityData)
                            }
                        }
                    }
                }
            }
        } else{
            JoinCommunityOrApplyView()
                .transition(.slide)
                .animation(.easeInOut(duration: 100.0),
                           value: AuthVM.isAuthorized)
        }
        
    }
    
    // Function to validate input
    private func isValidInput() -> Bool {
        return true //!firstName.isEmpty && !lastName.isEmpty && !username.isEmpty && isValidEmail(email) && isValidPassword(password) && password == passwordConfirmation
    }
}

