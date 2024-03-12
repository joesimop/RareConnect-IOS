//
//  donation.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/12/24.
//

import Foundation


extension APIRequest where Result == DonationPage {
    
    ///Creates a usable APIRequest to get the donation bage
    /// - Parameters:
    ///     - community_id: ID of community
    /// - Returns: APIRequest<DonationPage>
    static func getDonationPage(community_id : Int) -> APIRequest {
        return APIRequest(endpoint: "/communities/\(community_id)/donation/page", decoder: JSONDecoder())
    }
    
}

extension APIRequest where Result == APIResponseCode {
    
    //Not implemented yet
    static func donate(community_id : Int, profile_id : Int, amount : Decimal) -> APIRequest {
        
        ///Format the data to be passed to through JSON
        let body: [String: Any] = [
            "profile_id": profile_id,
            "amount": amount,
            "timestamp": Date.now
        ]
        
        return APIRequest(endpoint: "/communities/\(community_id)/donation/donate", body: body, method: RestMethod.POST) ?? APIRequest(errorCode: APIResponseCode.Error(.UnableToCreateHttpRequest))
    }
    
}
