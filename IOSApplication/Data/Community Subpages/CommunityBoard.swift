//
//  CommunityBoard.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/15/24.
//

import Foundation

///Data to toggle booleans in the database
struct BooleanToggle {
    var profile_id: Int
    var post_id: Int
    var old_bool_state: Bool
}

///Data for a comment on a post
struct Comment : Hashable, Decodable {
    var id: Int?
    var username : String?
    var profile_id: Int
    var post_id: Int
    var timestamp: Date
    var text: String
}

///Data for posts on the Community Board page
struct CommunityBoardPost : Identifiable, Hashable, Decodable {
    
    static func == (lhs: CommunityBoardPost, rhs: CommunityBoardPost) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id : Int
    var timestamp: Date
    var username: String
    var profile_id: Int
    var text: String
    var upvotes: Int
    var upvoted : Bool
    var favorited: Bool
    var pinned : Bool
    var comment_count: Int
    var comments: [Comment]
    
    
}

///Data for posts on the Community Board page
struct CommunityBoardPostAbbr : Identifiable, Hashable, Decodable {
    
    var id : Int
    var timestamp: Date
    var username: String
    var profile_id: Int
    var text: String
    var pinned : Bool
    
}


//Data needed to create a new Post
struct NewBoardPost {
    var profile_id: Int
    var text: String
    var pinned: Bool
}
