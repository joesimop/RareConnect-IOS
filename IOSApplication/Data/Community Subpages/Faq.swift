//
//  Faq.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/9/24.
//

import Foundation

struct FAQ: Decodable, Hashable {
    let id : Int?
    let order_number: Int
    let question: String
    let answer: String
}
