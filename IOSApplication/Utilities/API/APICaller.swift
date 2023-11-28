//
//  APICaller.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa

struct Example: Decodable{
    var tooth: Int
    var lit: String
}

struct APICaller{
    
    var session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = .shared
    }
    
    func sendSingleRequest<Element>(_ request: APIRequest<Element>) -> Single<Element> {
        session.rx.data(request: request.urlRequest)
            .map(request.handleResponse)
            .asSingle()
    }
}
