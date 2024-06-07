//
//  APIBase.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa

enum RestMethod : String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
}

//MARK: API Requst Struct
// An APIRequest is defined by the UrlRequest for the call and a way to repsond to it.
struct APIRequest<Result> {
    var urlRequest: URLRequest
    var handleResponse: (Data) throws -> Result
    let baseUrl: String = "http://127.0.0.1:8000"
}



//MARK: HTTP Code Response

//How to handle HTTPStatusCode Responses
private let HttpStatusCodeResponse =
{
    httpCodesToEnum[String(data: $0, encoding: .utf8)!] ?? APIResponseCode.Error(.BadRequest("Could identify status code"))
}

// When all we are is expecting a HTTPStatusCode and no information.
extension APIRequest where Result == APIResponseCode {
    

    //Endpoint as Argument
    init(endpoint: String){
        //Initialize Basic Url Components
        self.urlRequest = SetupUrlRequest(baseUrl, endpoint: endpoint)
        self.handleResponse = HttpStatusCodeResponse
    }
    
    //POST Request with body
    init?(endpoint: String, body: [String : Any], method: RestMethod) {
        
        //Initialize Basic Url Components
        self.urlRequest = SetupUrlRequest(baseUrl, endpoint: endpoint)
        
        do {
            try SerializeBody(request: &urlRequest, body: body)
        } catch {
            return nil
        }
        SetHttpMethod(request: &self.urlRequest, method: method)
        self.handleResponse = HttpStatusCodeResponse
    }
    
    //POST Request with body
    init?(endpoint: String, body: Data) {
        
        //Initialize Basic Url Components
        self.urlRequest = SetupUrlRequest(baseUrl, endpoint: endpoint)
        MakePostRequest(request: &urlRequest, body: body)
        self.handleResponse = HttpStatusCodeResponse
    }
    
    //Search Request
    init?(endpoint: String, searchValues: [String : String]) {
        
        //Initialize Basic Url Components
        self.urlRequest = SetupSearchRequest(baseUrl, endpoint: endpoint, searchValues: searchValues)
        
        SetHttpMethod(request: &self.urlRequest, method: RestMethod.GET)
        self.handleResponse = HttpStatusCodeResponse
    }
    
    
    //DELETE Request
    init(endpoint: String, method: RestMethod){
        self.urlRequest = SetupUrlRequest(baseUrl, endpoint: endpoint)
        SetHttpMethod(request: &urlRequest, method: method)
        self.handleResponse = HttpStatusCodeResponse
    }
    
    //Constructor for when a request couldn't be created
    init(errorCode: APIResponseCode){
        self.handleResponse = {_ in errorCode }
        self.urlRequest = SetupUrlRequest("", endpoint: "")
    }
}

//MARK: JSON Response
//API Requests that decode a JSON object
extension APIRequest where Result: Decodable {
    
    //URL Request is passed, used in cases where we need to setup a request beforehand (POSTS)
    init(urlRequest: URLRequest, decoder: JSONDecoder) {
        self.urlRequest = urlRequest
        self.handleResponse = { try decoder.decode(Result.self, from: $0) }
    }
    
    //Basic intitiliztion for a json response, generally just GET requests.
    init(endpoint: String, decoder: JSONDecoder) {
        //Initialize Basic Url Components
        self.urlRequest = SetupUrlRequest(baseUrl, endpoint: endpoint)
        self.handleResponse = { try decoder.decode(Result.self, from: $0) }
    }
}

//MARK: Void Response
//When we don't need the response...
extension APIRequest where Result == Void {
    
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        self.handleResponse = { _ in }
    }
    
    //POST Request with body
    init?(endpoint: String, body: [String : Any], method: RestMethod) {
        
        //Initialize Basic Url Components
        self.urlRequest = SetupUrlRequest(baseUrl, endpoint: endpoint)
        
        do {
            try SerializeBody(request: &urlRequest, body: body)
        } catch {
            return nil
        }
        SetHttpMethod(request: &self.urlRequest, method: method)
        self.handleResponse = { _ in }
    }
    
    init(errorCode: APIResponseCode){
        self.handleResponse = {_ in }
        self.urlRequest = SetupUrlRequest("", endpoint: "")
    }
}

struct ConcurrentAPIRequest<Result> {
    let key : String = UUID().uuidString
    let request : APIRequest<Result>
}

struct APIResultWithRequestIdentifier<Result> {
    let identifier : String
    let data : Result
}
