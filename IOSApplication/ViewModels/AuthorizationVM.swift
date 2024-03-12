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

class AuthorizationVM: ViewModel {
    
    var community_id: Int = 0
    var profile_id: Int = 0
    @Published var isAuthorized: Bool = false
    @Published var autoAuthorizationComplete: Bool = false
    private var dispatcher = ViewModelAPIDispatcher()
    
    static let userDefaultKey : String = "RareConnectUsernameKey"
    
    init() {
    }
    
    func Refresh() {
        return
    }
    
    
    //NEED TO BREAK CONVENTION FOR AUTHORIZATION DUE TO:
    //Populating enviroment objects requires the View to be instantiatied, therefore needs to be exectued in the OnAppear function
    func OnViewOpen() {
        return
    }
    
    func OnViewOpen(CommonVM: GeneralVM, psUserData: psUserClass, psCommunityData: psCommunityClass) {

        if let userCredentials = AuthorizationVM.CheckForUserCredentials() {
            dispatcher.SendRequestViewUpdate(.authorizeUser(username: userCredentials.0, password: userCredentials.1)) { authorized in
                if IsSuccessful(authorized) {
                    self.SetupApplicationState(username: userCredentials.0, CommonVM: CommonVM, psUserData: psUserData, psCommunityData: psCommunityData)
                }
            }
        }
        self.autoAuthorizationComplete = true
    }
    
    ///Authorize User Enpoint
    ///Escaping closure provided to pass in enviroment objects to be set by the view. (The enviroment objects should be separately, after authorization has happened)
    func AuthorizeUser(username: String, password: String, onSuccess: @escaping (String) -> Void ) -> Void{
        
        dispatcher.SendRequestViewUpdate(.authorizeUser(username: username, password: password)) { authorized in
            if IsSuccessful(authorized) {
                AuthorizationVM.UpdateCachedCredentials(username: username, password: password)
                onSuccess(username)
            }
        }
    }
    
    ///Create User Enpoint
    func CreateUser(newUser: UserProfileCreation, onSuccess: @escaping (String) -> Void ) -> Void{
        dispatcher.SendRequestViewUpdate(.createProfile(newUser: newUser)){ result in
            if IsSuccessful(result) {
                AuthorizationVM.UpdateCachedCredentials(username: newUser.username, password: newUser.password)
                onSuccess(newUser.username)
            }
        }
        
    }
    
    static func getUserDefault() -> String? {
        return UserDefaults.standard.string(forKey: AuthorizationVM.userDefaultKey)
    }
    
    static func setUserDefault(username: String) -> Void{
        UserDefaults.standard.set(username, forKey: AuthorizationVM.userDefaultKey)
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
        
        
        return nil
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
    
    func SetupApplicationState(username: String, CommonVM: GeneralVM, psUserData: psUserClass, psCommunityData: psCommunityClass) -> Void {
        //Get information from username
        CommonVM.GetUserByUsername(username: username){ userProfile in
            psUserData.SetProfile(profile: userProfile)
            
            //Get Communities for profile
            CommonVM.GetCommunitiesForProfile(profile_id: psUserData.id) { profileCommunities in
                psUserData.profileCommunities = profileCommunities
                
                //Set the community if we are automatically logging them a commmunity.
                if profileCommunities.count == 1 
                { 
                    psCommunityData.SetCommunity(community: profileCommunities[0])
                }
                
                //Update View State
                DispatchQueue.main.async {
                    self.isAuthorized = true
                }
                
            }
        }
        
    }
}
