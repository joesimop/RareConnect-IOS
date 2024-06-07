//
//  User.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/13/24.
//

import Foundation

///Enum for a profile's role within a community
enum eRole : String, CaseIterable, Decodable {
    case NoCredentials = "NC"
    case Member = "MEMBER"
    case Admin = "ADMIN"
}

///Enum for genders
enum eGender: String, CaseIterable, Decodable {
    case Male = "Male"
    case Female = "Female"
    case Other = "Other"
}

///Data for the information from the user signup form
struct UserProfileCreation {
    let id : Int
    let first_name: String
    let last_name: String
    let username: String
    let password: String
    let email: String
    let dob: String
    let gender: eGender
    let residing_city: String
}

///Data for a complete user profile.
struct UserProfile: Decodable {
    let id : Int
    let first_name: String
    let last_name: String
    let username: String
    let email: String?
    let dob: Date?
    let gender: eGender?
    let residing_city: String?
    let joined: Date?
    let role: eRole?
}
