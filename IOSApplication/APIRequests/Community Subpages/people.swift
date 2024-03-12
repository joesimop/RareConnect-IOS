//
//  people.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/28/24.
//

import Foundation



extension SearchAPIRequest where Result == [AbbrProfile] {
    
    ///Creates a usable SearchAPIRequest to search people in a community
    /// - Parameters:
    ///     - community_id: Community Identifier
    /// - Returns: APIRequest<[AbbrProfile]>
    static func searchProfiles(community_id: Int) -> SearchAPIRequest {
        return SearchAPIRequest(endpoint: "/communities/\(community_id)/people/search", searchableFields: ["firstname", "lastname", "username"])
    }
    
}
