//
//  FrontPageVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/11/23.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftUI

let api = APICaller()

var jsonDecoder = JSONDecoder()


//MARK: Uber Trips Endpoint
struct UberDataTripsCompleted: Decodable, Identifiable{
    var driverId: Int
    var tripsCompleted: Int
    var id: Int { driverId }
}

extension APIRequest where Result == [UberDataTripsCompleted] {
    
    //Gets total trips completed by driver sorted by # completed, desc
    static func getTripsCompleted() -> APIRequest {
        return APIRequest(endpoint: "/user/tripscompleted", decoder: jsonDecoder)
    }
}

//MARK: User Handling endpoints
extension APIRequest where Result == APIResponseCode {
    
    
}

//MARK: FrontPage VM Implementation
class FrontPageVM{
    
    private var bag = DisposeBag()
    
    
    ///GetTripsCompleted Endpoint
//    func GetTripsCompleted() -> Observable<[UberDataTripsCompleted]>{
//        return api.sendSingleRequestRx(.getTripsCompleted()).asObservable()
//    }
    
    ///Create User Enpoint
    func CreateUser(newUser: User,  response: Binding<APIResponseCode>) -> Void{
        ///Send API Request as Single Observable
        api.sendSingleRequestRx(
            ///Endpoint to  create a user
            .createUser(newUser: newUser))
            .asObservable()
            .BindValue(binding: response)
            .disposed(by: bag)
        
    }
    
    

}
