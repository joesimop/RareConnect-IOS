//
//  communities.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import Foundation

extension APIRequest where Result == [Community] {
    
    ///Creates a usable APIRequest to get all communities
    /// - Parameters:
    /// - Returns: APIRequest<[Community]>
    static func getAllCommunities() -> APIRequest {
        return APIRequest(endpoint: "/communities/all", decoder: JSONDecoder())
    }
    
}

extension APIRequest where Result == APIResponseCode {
    
    ///Creates a usable APIRequest to submit a request to join a community
    /// - Parameters:
    ///     - community_id: Community that is being applied to
    ///     - request: Object that holds information that is used in the body of the call.
    /// - Returns: APIRequest<APIResponseCode>
    static func submitCommunityRequest(community_id: Int, request : CommunityRequestBody) -> APIRequest {
        ///Format the data to be passed to through JSON
        let body: [String: Any] = [
            "profile_id": request.profile_id,
            "message": request.message
        ]
        
        return APIRequest(endpoint: "/communities/\(community_id)/request", body: body, method: RestMethod.POST)  ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
    ///Creates a usable APIRequest to submit a request to create a community
    /// - Parameters:
    ///     - application: Object that holds information for the request
    /// - Returns: APIRequest<APIResponseCode>
    static func submitCommunityApplication(application : CommunityApplicationBody) -> APIRequest {
        
        ///Format the data to be passed to through JSON
        let body: [String: Any] = [
            "profile_id": application.profile_id,
            "phone_number": application.phone_number,
            "professional_email" : application.professional_email,
            "organization_name" : application.organization_name,
            "answer1" : application.answer1,
            "answer2" : application.answer2,
            "message": application.message
        ]
        
        return APIRequest(endpoint: "/communities/application", body: body, method: RestMethod.POST)  ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))    
        
    }
    
}
