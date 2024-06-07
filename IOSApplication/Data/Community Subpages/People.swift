//
//  People.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/28/24.
//

import Foundation

//Data for an abbreviated profile
struct AbbrProfile: Decodable, Hashable {
    let id: Int
    let first_name: String
    let last_name: String
    let username: String
    let role: eRole
}
