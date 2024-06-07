//
//  Admin.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 5/20/24.
//

import Foundation

enum eAdminNotificationType : String, Decodable{
    case JoinRequest = "JOIN_REQUEST"
    case FlaggedPost = "FLAGGED_POST"
    case MemberJoined = "MEMBER_JOINED"
}

struct AdminNotification : Hashable, Decodable {
    let id : Int
    let type : eAdminNotificationType
    let timestamp : Date
    let text : String
}
