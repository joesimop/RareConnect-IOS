//
//  Guidelines.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/3/24.
//

import Foundation

extension APIRequest where Result == [Guideline] {
    
    ///Creates an usable APIRequest that gets  guidelines for a given community.
    /// - Parameters:
    ///     - community_id: Which community guidlines we are reordering
    /// - Returns: APIRequest<[Guideline>
    static func getCommunityGuidlines(community_id : Int) -> APIRequest {
        return APIRequest(endpoint: "/communities/\(community_id)/guidelines/all", decoder: JSONDecoder())
    }
    
}


extension APIRequest where Result == APIResponseCode {

    ///Creates a usable  APIRequest that creates a guideline in the backend.
    /// - Parameters:
    ///     - community_id: Which community's guidlines we are adding to
    ///     - guideline_id: The id of the guideline we are creating.
    /// - Returns: APIRequest<APIResponseCode>
    static func createGuideline(community_id : Int, orderNumber : Int, text : String) -> APIRequest {
        
        ///Format the data to be passed to through JSON
        let body: [String: Any] = [
            "order_number": orderNumber,
            "text": text
        ]
        
        return APIRequest(endpoint: "/communities/\(community_id)/guidelines/new", body: body, method: RestMethod.POST) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
    ///Creates a usable APIRequest to delete a guideline in the backend.
    /// - Parameters:
    ///     - community_id: Which community guidlines we are deleteing
    ///     - guideline_id: The id of the guideline we are deleting.
    /// - Returns: APIRequest<APIResponseCode>
    static func deleteGuideline(community_id : Int, guideline_id : Int) -> APIRequest {
        return APIRequest(endpoint: "/communities/\(community_id)/guidelines/delete/\(guideline_id)", method: RestMethod.DELETE)
    }
    
    ///Creates a usable  APIRequest to reorder guidelines in the backend.
    /// - Parameters:
    ///     - community_id: Which community guidlines we are reordering
    ///     - guideline_id: The id of the guideline we are reordering.
    ///     - fromOffset: The offset in the backend that we are moving from
    ///     - toOffset: The offset in the backend we are moving to
    /// - Returns: APIRequest<APIResponseCode>
    static func reOrderGuidelines(community_id : Int, guideline_id : Int, fromOffset : Int, toOffset : Int) -> APIRequest {
        return APIRequest(endpoint: "/communities/\(community_id)/guidelines/reorder/\(guideline_id)/\(fromOffset)/\(toOffset)")
    }
    
}
