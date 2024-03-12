//
//  users.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/19/24.
//

import Foundation

extension APIRequest where Result == UserProfile {
    
    ///Creates a usable APIRequest to get a profile by username
    /// - Parameters:
    ///     - community_id: Community Identifier
    /// - Returns: APIRequest<UserProfile>
    static func getProfileByUsername(username: String) -> APIRequest {
        return APIRequest(endpoint: "/profile/\(username)", decoder: JSONDecoder())
    }
    
    ///Creates a usable APIRequest to get a profile in the context of a community.
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - profile_id: Profile Identifier
    /// - Returns: APIRequest<AbbrProfile>
    static func getCommunityProfile(community_id: Int, profile_id: Int) -> APIRequest {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return APIRequest(endpoint: "/profile/community_profile/\(community_id)/\(profile_id)", decoder: decoder)
    }
    
}

extension APIRequest where Result == [AbbrCommunity] {
    
    ///Creates a usable APIRequest to get a profile's communities
    /// - Parameters:
    ///     - profile_id; Profile Identifier
    /// - Returns: APIRequest<[AbbrCommunity]>
    static func getCommunitiesForProfile(profile_id : Int) -> APIRequest {
        return APIRequest(endpoint: "/profile/\(profile_id)/communities", decoder: JSONDecoder())
    }
    
}

extension APIRequest where Result == [CommunityRequest] {
    
    ///Creates a usable APIRequest to get a profile's community requests
    /// - Parameters:
    ///     - profile_id; Profile Identifier
    /// - Returns: APIRequest<[CommunityRequest]>
    static func getCommunityRequests(profile_id : Int) -> APIRequest {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return APIRequest(endpoint: "/profile/\(profile_id)/community_requests", decoder: jsonDecoder)
    }
}


extension APIRequest where Result == APIResponseCode {
    
    ///Creates a usable APIRequest to create a user in the backend
    /// - Parameters:
    ///     - newUser: An object that holds the necessary data to create a profile
    /// - Returns: APIRequest<[CommunityRequest]>
    static func createProfile(newUser: UserProfileCreation) -> APIRequest {
        
        //Format the data to be passed to through JSON
        let body: [String: Any] = [
            "id" : newUser.id,
            "firstname": newUser.firstname,
            "lastname": newUser.lastname,
            "username": newUser.username,
            "gender": newUser.gender.rawValue,
            "email": newUser.email,
            "age": newUser.age,
            "password": newUser.password,
            "residingcity": newUser.residingCity
        ]
        
        ///Create the API Request
        return APIRequest(endpoint: "/profile/create", body: body, method: RestMethod.POST) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
}
