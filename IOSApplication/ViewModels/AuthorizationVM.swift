//
//  AuthenticationVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/13/23.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftUI

class AuthorizationClass: ObservableObject {
    
    @Published var isAuthorized: Bool = false
    @Published var autoAuthorizationComplete: Bool = false
    @Published var showLogin: Bool = false;
    
    private var dispatcher = ViewModelAPIDispatcher()
    
    static let userDefaultKey : String = "RareConnectUsernameKey"

    func OnViewOpen(onSuccess: @escaping (String) -> Void) {

        //Check to see if we have already logged in the user automatically
        //This won't be true if the user has logged out
        if (!autoAuthorizationComplete){
            
            //Get cached credendtials
            if let userCredentials = AuthorizationClass.CheckForUserCredentials() {
                
                //Authorize cached user
                dispatcher.SendRequestViewUpdate(.authorizeUser(username: userCredentials.0, password: userCredentials.1)) { authorized in
                    
                    //If we are successful, update the user state, outside of here, otherwise,
                    //have them login
                    if IsSuccessful(authorized) {
                        onSuccess(userCredentials.0)
                    } else {
                        self.showLogin = true
                    }
                }
            }
        }
        autoAuthorizationComplete = true
    }
    
    ///Authorize User Enpoint
    ///Escaping closure provided to pass in enviroment objects to be set by the view. (The enviroment objects should be separately, after authorization has happened)
    func AuthorizeUser(username: String, password: String, resultBinding: Binding<APIResponseCode>, onSuccess: @escaping (String) -> Void) -> Void{
        
        dispatcher.SendRequestViewUpdate(.authorizeUser(username: username, password: password)) { authorized in
            switch authorized{
            case .success( let success):
                resultBinding.wrappedValue = success.data
                AuthorizationClass.UpdateCachedCredentials(username: username, password: password)
                onSuccess(username)
                return
            case .failure( let failure ):
                resultBinding.wrappedValue = APIResponseCode.Error(failure)
            }

        }
    }
    
    ///Create User Enpoint
    func CreateUser(newUser: UserProfileCreation, onSuccess: @escaping (String) -> Void ) -> Void{
        dispatcher.SendRequestViewUpdate(.createProfile(newUser: newUser)){ result in
            if IsSuccessful(result) {
                AuthorizationClass.UpdateCachedCredentials(username: newUser.username, password: newUser.password)
                onSuccess(newUser.username)
            }
        }
        
    }
    
    static func getUserDefault() -> String? {
        return UserDefaults.standard.string(forKey: AuthorizationClass.userDefaultKey)
    }
    
    static func setUserDefault(username: String) -> Void{
        UserDefaults.standard.set(username, forKey: AuthorizationClass.userDefaultKey)
    }
    
    static func saveCredentials(username: String, password: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: username,
            kSecValueData: password.data(using: .utf8)!
        ] as CFDictionary

        SecItemAdd(query, nil)
    }
    
    static func retrievePassword(username: String) -> String {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        // Check if user exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               let _ = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                return password
            }
        } else {
            print("Something went wrong trying to find the user in the keychain")
        }
        
        //Return empty string if there was an error finding the password
        return ""
    }
    
    static func UpdateKeychainPassword(username: String, newPassword: String) -> Bool {
        
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        // Set attributes for the new password
        let attributes: [String: Any] = [kSecValueData as String: newPassword.data(using: .utf8)!]
        // Find user and update
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
            return true
        }
        
        //Return false if it didn't update correctly
        return false
    }
    
    static func DeleteKeychainCredentials(username: String) -> Bool{
        
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        
        // Find user and delete
        if SecItemDelete(query as CFDictionary) == noErr {
            return true
        }
        
        return false
    }
    
    static func CheckForUserCredentials() -> (String, String)?{
        
        
        //return nil
        ///Check if we have stored credentials
        if let storedUsername = self.getUserDefault(){
            let storedPassword = self.retrievePassword(username: storedUsername)
            print("Logged in as: \(storedUsername)")
            return (storedUsername, storedPassword)
        }
        return nil
    }
    
    static func UpdateCachedCredentials(username: String, password: String){
            
        ///Check if we have stored credentials
        if let storedUsername = Self.getUserDefault(){
            
            //If this is a new username, then store it, and replace the previous
            if storedUsername != username {
                
                ///First delete the previous user information so there is no longer access to it
                if(Self.DeleteKeychainCredentials(username: storedUsername))
                {
                    print("Deleted previous user: \(storedUsername)")
                }
                
                ///Add the new information
                Self.setUserDefault(username: username)
                Self.saveCredentials(username: username, password: password)
            }
            
        ///If there are no credentials stored the username in UserDefaults
        } else {
            Self.setUserDefault(username: username)
            Self.saveCredentials(username: username, password: password)
        }
    }
    
    func AutoAuthorizeValidated(){
        DispatchQueue.main.async{
            self.isAuthorized = true
        }
    }
    
    func ManualAuthorizationValidated(){
        DispatchQueue.main.async{
            self.isAuthorized = true
            self.showLogin = false
        }
    }
    
    func Logout(){
        self.isAuthorized = false
        self.showLogin = true
    }
}
