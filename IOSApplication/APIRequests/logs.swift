//
//  logs.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 4/22/24.
//

import Foundation

extension APIRequest where Result == Void {
    
    ///Creates a usable APIRequest to log when a user closes the app
    /// - Parameters:
    ///     - profile_id: The profile_id that you want to logout
    ///     - community_id: The current community that is active
    /// - Returns: APIResponseCode
    static func log_app_close(profile_id: Int, community_id: Int) -> APIRequest {
        
        //Format the data to be passed to through JSON
        let body: [String: Any] = [
            "profile_id": profile_id,
            "community_id": community_id
        ]
        
        ///Create the API Request
        return APIRequest(endpoint: "/logs/app_close", body: body, method: RestMethod.POST) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
}
