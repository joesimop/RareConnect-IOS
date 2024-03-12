//
//  Guidelines.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/3/24.
//

import Foundation

///Data to display a Community Guideline
struct Guideline : Decodable, Hashable {
    let id : Int
    let order_number : Int
    let text : String
}
