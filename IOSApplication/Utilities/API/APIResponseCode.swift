//
//  HTTPStatusCode.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/4/23.
//

import Foundation

///Returns true if an API call is successful and false if it wasn't.
func IsSuccessful(_ apiresponse: APIResponseCode) -> Bool{
    switch apiresponse{
    case APIResponseCode.Success:
        return true
    default:
        return false
    }
}

//Returns true if an APIResult<APIResponseCode> was successful and false if it wasn't.
func IsSuccessful(_ apiresponse: APIResult<APIResponseCode>) -> Bool{
    switch apiresponse{
    case .success(_):
        return true
    case .failure(_):
        return false
    }
}

///Enum that holds the possible HTTP responses returned
enum APIResponseCode {
    
    ///Successful HTTP repsonses.
    enum APISuccess {
        case Ok
        case Created
        case NoContent
    }

    ///Failed HTTP responses
    enum APIError : Error {
        case BadRequest(String)
        case Unauthorized(String)
        case Forbidden(String)
        case NotFound(String)
        case InternalServerError(String)
        case BadGateway(String)
        case ServiceUnavailable(String)
        case SwiftError(String)
        case HttpRequestFailed(String)
        case TimedOut
        case UnableToCreateHttpRequest
        case DeserializationError
        case NonHttpResponse
        case Unknown
        case BackendError
    }

    case Success(APISuccess)
    case Error(APIError)
    case NotSent
    case Waiting
    
    ///A string explanation of what the HTTP response means.
    var description: String {
        switch self {
        case .Success(let success):
            switch success {
            case .Ok: return "OK"
            case .Created: return "Created"
            case .NoContent: return "No Content"
            }
        case .Error(let error):
            switch error {
            case  .BadRequest(let message),
                 .Unauthorized(let message),
                 .Forbidden(let message),
                 .NotFound(let message),
                 .InternalServerError(let message),
                 .BadGateway(let message),
                 .ServiceUnavailable(let message),
                 .SwiftError(let message),
                 .HttpRequestFailed(let message):
                return message
            case .TimedOut: return "HTTP Request Timed Out"
            case .DeserializationError: return "Could not deserialize the returned JSON Object"
            case .NonHttpResponse: return "Non HTTP Response Was Returned"
            case .UnableToCreateHttpRequest: return "Unable To Create HTTP Request"
            case .Unknown: return "Unknown Error Occurred"
            case .BackendError: return "Backend Error"
            }
        case .NotSent: return "HTTP Request Not Sent"
        case .Waiting: return "Waiting for repsonse..."
        }
    }
}
