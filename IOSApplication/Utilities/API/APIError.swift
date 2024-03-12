//
//  APIError.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/7/23.
//

import Foundation

enum APIError : Error {
    
    case InvalidJsonBody
    
    case InvalidEndpoint
    
    case UnableToCreateApiRequest
    
    var description : String {
        switch self {
            
        case .InvalidJsonBody:
            return "Given body could not be serialized, API request not created"
            
        case .UnableToCreateApiRequest:
            return "Could not create API Request."
            
        case .InvalidEndpoint:
            return "Endpoint could not be found"
        }
        
    }
}
