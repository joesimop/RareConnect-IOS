//
//  UberVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/7/23.
//

import Foundation
import RxSwift
import RxCocoa

let api = APICaller()

var baseUrlString = "http://127.0.0.1:8000"
var jsonDecoder = JSONDecoder()

struct UberDataTripsCompleted: Decodable, Identifiable{
    var driverId: Int
    var tripsCompleted: Int
    var id: Int { driverId }
}

extension APIRequest where Result == [UberDataTripsCompleted] {
    
    //Gets total trips completed by driver sorted by # completed, desc
    static func getTripsCompleted() -> APIRequest {
        var components = URLComponents(string: baseUrlString)!
        components.path = "/user/tripscompleted"
        return APIRequest(urlRequest: URLRequest(url: components.url!), decoder: jsonDecoder)
    }
}

class UberVM{
    
    func GetTripsCompleted() -> Single<[UberDataTripsCompleted]>{
        return api.sendSingleRequest(.getTripsCompleted())
    }

}
