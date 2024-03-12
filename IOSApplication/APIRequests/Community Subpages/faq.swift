//
//  faq.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/9/24.
//

import Foundation

extension APIRequest where Result == [FAQ] {
    
    ///Creates an usable APIRequest that gets FAQs for a given community.
    /// - Parameters:
    ///     - community_id: Which community FAQs we are grabbing
    /// - Returns: APIRequest<[FAQ]>
    static func getFAQs(community_id : Int) -> APIRequest {
        return APIRequest(endpoint: "/communities/\(community_id)/faq/all", decoder: JSONDecoder())
    }
    
}


extension APIRequest where Result == APIResponseCode {

    ///Creates a usable APIRequest that creates a new FAQ in the backend.
    /// - Parameters:
    ///     - community_id: Which community's FAQs we are adding to
    ///     - newFaq: The object that holds the relevant data to create a new FAQ
    /// - Returns: APIRequest<APIResponseCode>
    static func submitFAQ(community_id : Int, newFaq: FAQ) -> APIRequest {
        
        ///Format the data to be passed to through JSON
        let body: [String: Any] = [
            "order_number": newFaq.order_number,
            "question": newFaq.question,
            "answer": newFaq.answer
        ]
        
        return APIRequest(endpoint: "/communities/\(community_id)/faq/submit", body: body, method: RestMethod.POST) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
    ///Creates a usable APIRequest to delete a FAQ in the backend.
    /// - Parameters:
    ///     - community_id: Which community FAQ we are deleteing from
    ///     - faqId: The id of the FAQ we are deleting.
    ///     
    /// - Returns: APIRequest<APIResponseCode>
    static func deleteFAQ(community_id : Int, faqId : Int) -> APIRequest {
        return APIRequest(endpoint: "/communities/\(community_id)/faq/delete/\(faqId)", method: RestMethod.DELETE)
    }
    
    ///Creates a usable  APIRequest to reorder FAQs in the backend.
    /// - Parameters:
    ///     - community_id: Which community's FAQs we are reordering
    ///     - faqId: The id of the FAQ we are reordering.
    ///     - fromOffset: The offset in the backend that we are moving from
    ///     - toOffset: The offset in the backend we are moving to
    /// - Returns: APIRequest<APIResponseCode>
    static func reorderFAQ(community_id : Int, faqId : Int, fromOffset : Int, toOffset : Int) -> APIRequest {
        return APIRequest(endpoint: "/communities/\(community_id)/faq/reorder/\(faqId)/\(fromOffset)/\(toOffset)")
    }
    
}
