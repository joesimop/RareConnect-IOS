//
//  APIHelperFuncs.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/7/23.
//

import Foundation
import RxSwift
import RxCocoa

///Setups up the actual data structure in swift that makes the request
func SetupUrlRequest(_ baseUrl: String, endpoint: String) -> URLRequest {
    
    var components = URLComponents(string: baseUrl)!
    components.path = endpoint
    return URLRequest(url: components.url!)
    
}

///Sets up data structure to perform search queries
func SetupSearchRequest(_ baseUrl: String, endpoint: String, searchValues: [String : String]) -> URLRequest {
    
    var components = URLComponents(string: baseUrl)!
    for pair in searchValues{
        components.queryItems?.append(URLQueryItem(name: pair.key, value: pair.value))
    }
    components.path = endpoint
    return URLRequest(url: components.url!)
    
}

///Sets the body value of a POST request
func SerializeBody( request: inout URLRequest, body: [String : Any]) throws -> Void {
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do{
        request.httpBody = try SerializeBody(body)
    } catch { }
    
}

///Sets the httpMethod of a URLRequest
func SetHttpMethod(request: inout URLRequest, method: RestMethod) -> Void {
    request.httpMethod = method.rawValue
}

///Makes the URLRequest a PostRequest
func MakePostRequest( request: inout URLRequest, body: Data) -> Void {
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = body
}



///Used to Isolate error message returned by HTTP call
struct ErrorDetail: Decodable {
    var detail : String
}

///Translates an RxCocoa Error to an error reperesentable in our system
func HandleHttpError(_ error: any Error) -> APIResponseCode.APIError {
    
    if let httpError = error as? RxCocoaURLError {
        
        /// This is the general description
        print(httpError.debugDescription)
        
        /// Maps RxSwift error results into an APIRequestStatus
        switch httpError {
            
            case .unknown:
                return APIResponseCode.APIError.Unknown
            
            case .nonHTTPResponse(response: _):
                return APIResponseCode.APIError.NonHttpResponse
            
            case .httpRequestFailed(response: _ , data: let data):
            
                ///First try to decode the response into a detail JSON error.
                do{
                    let errorOutput : ErrorDetail = try JSONDecoder().decode(ErrorDetail.self, from: data!)
                    print("Error: \(errorOutput.detail)")
                    return APIResponseCode.APIError.HttpRequestFailed(errorOutput.detail)
                    
                ///If not, just return a deserilzation error
                } catch {
                    return APIResponseCode.APIError.DeserializationError
                }
                
                      
            case .deserializationError(error: let error):
                print("Error: \(error.localizedDescription)")
                return APIResponseCode.APIError.DeserializationError
        }
    //Only happens if a weird, weird swift error happens.
    } else {
        print("Non RxSwift Error:", error.localizedDescription)
        return APIResponseCode.APIError.SwiftError(error.localizedDescription)
    }
}


//Serializes Json Body for API requests
func SerializeBody(_ body: [String : Any]) throws -> Data  {
    do{
        return try JSONSerialization.data(withJSONObject: body)
    } catch {
        return Data()
    }
}

///Maps return strings to enum status values,
///NOTE: Only need Success because the error responses are handled by the HandleHttpError(error) function
///     The separate success and error cases are handled by Rx and neither will happen in the same call so this safe.
let httpCodesToEnum: [String: APIResponseCode] = [
    "200": APIResponseCode.Success(.Ok),
    "201": APIResponseCode.Success(.Created),
    "204": APIResponseCode.Success(.NoContent),
]

// Passing type to for general apirequests to be handled.
enum PossibleAPIData {
    case responseCode(APIResponseCode)
    case jsonObject(any Decodable)
    case unknown
}

// Unwraps APIResult data. The cases in this function are the possible
// types that an APIRequest returns.
func safelyUnwrapData(_ value: Any?) -> PossibleAPIData {
    switch value {

    case let enumValue as APIResponseCode:
        return .responseCode(enumValue)
        
    case let decodableValue as Decodable:
        return .jsonObject(decodableValue)
        
    default:
        return .unknown
        
    }
}
