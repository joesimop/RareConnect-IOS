//
//  ApplicationState.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import Foundation

//ps stands for "Persitent Storage"


///Common data regardless of community or profile
class psCommonDataClass : ObservableObject {
    var allCommunities : [Community] = []
}

///Data that persists about the selected community throughtout the session of the app.
class psCommunityClass : ObservableObject {
    var id : Int = 0
    var name : String  = ""
    var role : eRole = eRole.NoCredentials
    
    func SetCommunity(community: AbbrCommunity){
        self.id = community.id
        self.name = community.name
        self.role = community.role
    }
    
    func AsAbbrCommunity() -> AbbrCommunity {
        return AbbrCommunity(id: self.id, name: self.name, role: self.role)
    }
    
    func Reset(){
        self.id = 0
        self.name = ""
        self.role = eRole.NoCredentials
    }
}

///Data that persists about the user throughout the session of the app
class psUserClass : ObservableObject {
    
    //Initial values for on app startup
    var id : Int = 0
    var firstname : String = ""
    var lastname : String = ""
    var username : String = ""
    var profileCommunities : [AbbrCommunity] = []
    
    ///Sets the profile of the persistent data, given a UserProfile
    func SetProfile(profile : UserProfile){
        self.id = profile.id
        self.firstname = profile.first_name
        self.lastname = profile.last_name
        self.username = profile.username
    }
    
    func Reset(){
        self.id = 0
        self.firstname = ""
        self.lastname = ""
        self.username = ""
        self.profileCommunities = []
    }
}

struct NavigationPath : Identifiable, Hashable{
    let id = UUID()
    let name : String
}
