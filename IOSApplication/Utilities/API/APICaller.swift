//
//  APICaller.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa

typealias SendableSearchRequest<T> = (URLRequest, (Data) throws -> T)


//NOTE: It might be worth passing a urlRequest who's handling is determined by the generic Element.
//      Not sure how to do that, but it would be much less weight than passing APIRequests and SearchAPIRequests, and allow for
//      just one function.

struct APICaller{
    
    static let shared = APICaller()
    
    var session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = .shared
    }
    
    //Note: Observable handles the status codes, so on any API Call, it will
    //      only return the data if 200<=StatusCode<300
    func sendSingleRequestRx<Element>(_ request: APIRequest<Element>) -> Single<Element> {
        session.rx.data(request: request.urlRequest)
            .map(request.handleResponse)
            .asSingle()
    }
    
    //Sends a search request. These are different in essecence and require their own object
    //Essentially just a funciton override
    func sendSingleRequestRx<Element>(_ request: SendableSearchRequest<Element>) -> Single<Element> {
        session.rx.data(request: request.0)
            .map(request.1)
            .asSingle()
    }

    //Sends an API request with a unique identifier (for retry logic, will implement soon).
    func sendSingleRequestRxWithIdentifier<Element>(_ request: ConcurrentAPIRequest<Element>) -> Observable<APIResult<Element>> {
        session.rx.data(request: request.request.urlRequest)
            .map(request.request.handleResponse)
            .asObservable()
            .map{ result in .success(APIResultWithRequestIdentifier(identifier: request.key, data: result.self)) }
            .catch{error in Observable.just(.failure(HandleHttpError(error)))}
    }

}
