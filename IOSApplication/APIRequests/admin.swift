//
//  admin.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 5/20/24.
//

import Foundation

extension APIRequest where Result == [AdminNotification] {
    
    ///Creates a usable APIRequest to get a the admin notifications of a community.
    /// - Parameters:
    ///     - community_id: Community Identifier
    /// - Returns: APIRequest<[AdminNotification]>
    static func getAdminNotifications(community_id: Int) -> APIRequest {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return APIRequest(endpoint: "/\(community_id)/admin/notifications", decoder: decoder)
    }
}

extension APIRequest where Result == APIResponseCode {
    
    ///Creates a usable APIRequest that permits a post that was flagged by the AI.
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - notification_id: Id of Notfication that represents the flagged post
    ///     - allow_post: Whether to allow the post or not
    /// - Returns: APIRequest<APIResponseCode>
    static func permitFlaggedPost(community_id: Int, notification_id: Int, allow_post: Bool) -> APIRequest {
        
        let body: [String: Any] = [
            "notification_id": notification_id,
            "allowed": allow_post
        ]
        
        return APIRequest(endpoint: "/\(community_id)/admin/permit_post", body: body, method: RestMethod.POST) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
}
