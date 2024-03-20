//
//  community_updates.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/17/24.
//

import Foundation

extension APIRequest where Result == [AbbrArticle] {
    
    ///Creates a usable APIRequest to get a list commuinty updates for a community, currently not paginated
    /// - Parameters:
    ///     - community_id: Community Identifier
    /// - Returns: APIRequest<[AbbrArticle]>
    static func getCommunityUpdates(community_id: Int) -> APIRequest {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return APIRequest(endpoint: "/communities/\(community_id)/community_updates/all", decoder: jsonDecoder)
    }
}

extension APIRequest where Result == Article {
    
    ///Creates a usable APIRequest to get  the content of a specific article from an article id
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - article_id: Article identifier
    /// - Returns: APIRequest<Article>
    static func getArticle(community_id: Int, article_id: Int) -> APIRequest {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return APIRequest(endpoint: "/communities/\(community_id)/community_updates/\(article_id)", decoder: jsonDecoder)
    }
}

extension APIRequest where Result == APIResponseCode {
    
    ///Creates a usable APIRequest to get create a community update for a community
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - article: Object that holds data for new article
    /// - Returns: APIRequest<APIResponseCode>
    static func submitArticle(community_id: Int, article: Article) -> APIRequest {
        
        let body: [String: Any] = [
            "title": article.title,
            "abstract": article.abstract,
            "content": article.content
        ]
        
        return APIRequest(endpoint: "/communities/\(community_id)/community_updates/submit", body: body, method: RestMethod.PUT) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
    ///Creates a usable APIRequest to delete an article from a community
    /// - Parameters:
    ///     - community_id: Community Identifier
    ///     - article_id: Article Identifier
    /// - Returns: APIRequest<APIResponseCode>
    static func deleteArticle(community_id: Int, article_id: Article) -> APIRequest {
        return APIRequest(endpoint: "/communities/\(community_id)/community_updates/\(article_id)", method: RestMethod.DELETE)
    }
}
