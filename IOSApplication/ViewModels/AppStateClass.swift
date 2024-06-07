//
//  AppStateVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 4/20/24.
//

import Foundation

class AppStateClass : ObservableObject {
    
    var user : psUserClass = psUserClass()
    var community : psCommunityClass = psCommunityClass()
    var CommonVM : GeneralVM = GeneralVM()
    
    func SetCommunity(newCommunity: AbbrCommunity){
        self.community.SetCommunity(community: newCommunity)
    }
    
    func Logout(){
        self.user.Reset()
        self.community.Reset()
    }
    
    func SetupApplicationState(username: String, onComplete: @escaping () -> Void) -> Void {
        //Get information from username
        CommonVM.GetUserByUsername(username: username){ userProfile in
            self.user.SetProfile(profile: userProfile)
            
            //Get Communities for profile
            self.CommonVM.GetCommunitiesForProfile(profile_id: self.user.id) { profileCommunities in
                self.user.profileCommunities = profileCommunities
                
                //Set the community if we are automatically logging them a commmunity.
                if profileCommunities.count == 1
                {
                    self.community.SetCommunity(community: profileCommunities[0])
                }
                
                //Execute necessary logic from calling function.
                onComplete()
            }
        }
    }
    
}
