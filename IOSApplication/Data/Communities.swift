//
//  Communities.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/22/24.
//

import Foundation

///The method in which a community is joined by a user
enum JoinMethod : String, CaseIterable, Decodable {
    case Public = "public"
    case Private = "private"
    case Paywall = "paywall"
    
}

///The status of a user's request to join a community.
enum eRequestStatus : String, CaseIterable, Decodable {
    case Pending = "pending"
    case Accepted = "accepted"
    case Rejected = "rejected"
}

///Data necessary to represent a community
struct Community : Hashable, Decodable {
    let id : Int
    let name : String
    let abbr : String
    let join_method : JoinMethod
}

///Necessary data to distinguish a community
struct AbbrCommunity : Decodable, Hashable {
    let id : Int
    let name : String
    let role : eRole
}

///Data that indicates a user's request status to a specific community
struct CommunityRequest : Decodable, Hashable {
    let id : Int
    let name : String
    let status : eRequestStatus
    let submit_date : Date
}

///Data to submit a community request
struct CommunityRequestBody {
    let profile_id : Int
    let message : String
}

///Data to submit to request to create a community.
struct CommunityApplicationBody : Codable {
    let profile_id : Int
    let phone_number : String
    let professional_email : String
    let organization_name : String
    let answer1 : String
    let answer2 : String
    let message : String
    
}
