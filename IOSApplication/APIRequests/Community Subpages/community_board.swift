//
//  community_board.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/18/24.
//

import Foundation

extension APIRequest where Result == [CommunityBoardPost] {
    
    ///Creates a usable APIRequest to get all posts for a community's community board
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - profile_id:  User's id to deisgnate which posts they've favorited/pinned or not.
    /// - Returns: APIRequest<[CommunityBoardPost]>
    static func getBoardPosts(community_id: Int, profile_id: Int) -> APIRequest {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return APIRequest(endpoint: "/communities/\(community_id)/board/posts/\(profile_id)", decoder: jsonDecoder)
    }
    
    ///Creates a usable APIRequest to get pinned posts  for a community's community board
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - profile_id:  User's id to deisgnate which posts they've favorited or not.
    /// - Returns: APIRequest<[CommunityBoardPost]>
    static func getPinnedPosts(community_id: Int, profile_id: Int) -> APIRequest {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return APIRequest(endpoint: "/communities/\(community_id)/board/posts/\(profile_id)/pinned", decoder: jsonDecoder)
    }
}

extension APIRequest where Result == [Comment] {
    
    ///Creates a usable APIRequest to get comments for a specific post
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - post_id:  Post identifier to get comments for
    /// - Returns: APIRequest<[Comment]>
    static func getComments(community_id: Int, post_id: Int) -> APIRequest {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return APIRequest(endpoint: "/communities/\(community_id)/board/comments/\(post_id)", decoder: jsonDecoder)
    }
}

extension APIRequest where Result == APIResponseCode {
    
    
    ///Creates a usable APIRequest to toggle an upvote on a post
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - body:  Consists of a profile_id, post_id, current_boolean_state
    /// - Returns: APIRequest<APIResponseCode>
    static func upvoteToggle(community_id : Int, body: BooleanToggle) -> APIRequest {
        
        ///Format the data to be passed to through JSON
        let body: [String: Any] = [
            "profile_id": body.profile_id,
            "post_id": body.post_id,
            "old_bool_state": body.old_bool_state
        ]
        
        return APIRequest(endpoint: "/communities/\(community_id)/board/upvote_toggle", body: body, method: RestMethod.PUT) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
    ///Creates a usable APIRequest to toggle a favorite on a post
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - body:  Consists of a profile_id, post_id, current_boolean_state
    /// - Returns: APIRequest<APIResponseCode>
    static func favoriteToggle(community_id : Int, body: BooleanToggle) -> APIRequest {
        
        ///Format the data to be passed to through JSON
        let body: [String: Any] = [
            "profile_id": body.profile_id,
            "post_id": body.post_id,
            "old_bool_state": body.old_bool_state
        ]
        
        return APIRequest(endpoint: "/communities/\(community_id)/board/favorite_toggle", body: body, method: RestMethod.PUT) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
    ///Creates a usable APIRequest to toggle a pin on a post
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - post_id: Post identifier for which the pin will be toggled
    /// - Returns: APIRequest<APIResponseCode>
    static func pinToggle(community_id: Int, post_id: Int) -> APIRequest {
        return APIRequest(endpoint: "/communities/\(community_id)/board/pin_toggle/\(post_id)", method: RestMethod.PUT)
    }
    
    ///Creates a usable APIRequest to comment on a post
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - newComment:  Comment object that neeeds to be populated to submit in the body of a request
    /// - Returns: APIRequest<APIResponseCode>
    static func commentPost(community_id: Int, newComment: Comment) -> APIRequest {
        
        ///Format the data to be passed to through JSON
        let commentData: [String: Any] = [
            "post_id": newComment.post_id,
            "profile_id": newComment.profile_id,
            "text": newComment.text,
            "timestamp": newComment.timestamp.ISO8601Format()
        ]
        return APIRequest(endpoint: "/communities/\(community_id)/board/comment", body: commentData, method: RestMethod.POST) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
    ///Creates a usable APIRequest to create a post in a community
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - newPost:  Post object that neeeds to be populated to submit in the body of a request
    /// - Returns: APIRequest<APIResponseCode>
    static func postToBoard(community_id: Int, newPost: NewBoardPost) -> APIRequest {
        // Format the data to be passed through JSON
        let postData: [String: Any] = [
            "profile_id": newPost.profile_id,
            "text": newPost.text,
            "pinned": newPost.pinned,
            "timestamp": Date.now.ISO8601Format()
        ]
        
        // Construct the endpoint
        let endpoint = "/communities/\(community_id)/board/post"
        
        // Create and return the APIRequest
        return APIRequest(endpoint: endpoint, body: postData, method: RestMethod.POST) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
}

extension SearchAPIRequest where Result == [CommunityBoardPostAbbr] {
    
    ///Creates a usable SearchAPIRequest to search posts in a community
    /// - Parameters:
    ///     - community_id: Community Identifier
    /// - Returns: APIRequest<[CommunityBoardPostAbbr]>
    static func searchCommunityBoard(community_id: Int) -> SearchAPIRequest {
        return SearchAPIRequest(endpoint: "/communities/\(community_id)/board/search", searchableFields: ["username", "body"])
    }
    
}

