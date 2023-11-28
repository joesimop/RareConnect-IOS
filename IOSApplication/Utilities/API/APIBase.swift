//
//  APIBase.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa

enum APIRequestType : String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
}

// defines an APIRequest by the URLRequest needed to make the request and the
// function needed to parse the response
struct APIRequest<Result> {
    
    let urlRequest: URLRequest
    let handleResponse: (Data) throws -> Result
    
    public init(request: URLRequest, response: @escaping (Data) throws -> Result) {
            self.urlRequest = request
            self.handleResponse = response
        }
}

// when you don't need the response, use this init to create the request
extension APIRequest where Result == Void {
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        self.handleResponse = { _ in }
    }
}

// this init is for when the response is decodable via a JSONDecoder.
// we pass in the Decoder so that we can configure it.
extension APIRequest where Result: Decodable {
    init(urlRequest: URLRequest, decoder: JSONDecoder) {
        self.urlRequest = urlRequest
        self.handleResponse = { try decoder.decode(Result.self, from: $0) }
    }
}


