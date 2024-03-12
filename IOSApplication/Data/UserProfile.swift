//
//  User.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/13/24.
//

import Foundation

///Enum for a profile's role within a community
enum eRole : String, CaseIterable, Decodable {
    case NoCredentials = "nc"
    case Member = "member"
    case Admin = "admin"
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
    let firstname: String
    let lastname: String
    let username: String
    let password: String
    let email: String
    let age: String
    let gender: eGender
    let residingCity: String
}

///Data for a complete user profile.
struct UserProfile: Decodable {
    let id : Int
    let firstname: String
    let lastname: String
    let username: String
    let email: String?
    let age: Int?
    let gender: eGender?
    let residingcity: String?
    let joined: Date?
    let role: eRole?
}
