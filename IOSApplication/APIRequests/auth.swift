//
//  auth.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/19/24.
//

import Foundation

extension APIRequest where Result == APIResponseCode {
    
    ///Creates a usable APIRequest to authorize credentials in the database
    /// - Parameters:
    ///     - username: Username credential
    ///     - password: password credential
    /// - Returns: APIRequest<[CommunityRequest]>
    static func authorizeUser(username: String, password: String) -> APIRequest {
        
        ///Format the data to be passed to through JSON
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        ///Create the API Request
        return APIRequest(endpoint: "/profile/authorize", body: body, method: RestMethod.POST) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
   
}
