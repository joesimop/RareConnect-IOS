//
//  Community Updates.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/17/24.
//

import Foundation

enum eArticleType : String, RawRepresentable, CaseIterable {
    case PDF = "pdf"
    case HTML = "html"
    case Text = "text"
}

struct AbbrArticle: Decodable, Hashable {
    let id: Int
    let title: String
    let abstract: String
    let timestamp: Date
}

struct Article: Decodable, Hashable {
    let id: Int?
    let title: String
    let abstract: String
    let content: String
    let timestamp: Date
}
