
import Foundation
import RxSwift
import RxCocoa
import SwiftUI
import Security






//extension APIRequest where Result == APIRequestStatus {
//    
//    /// Creates a User in the database
//    static func createUser(username: String, password: String) -> APIRequest {
//        
//        //Format the data to be passed to through JSON
//        let body: [String: Any] = [
//            "username": username,
//            "password": password
//        ]
//        
//        ///Create the API Request
//        return APIRequest(endpoint: "/user/create", body: body) ?? APIRequest(errorCode: APIRequestStatus.UnableToCreateHttpRequest)
//    }
//}

///A class that calls and returns a value of an API Request
class UserHandling{
    
    private var bag = DisposeBag()
    
//    func CreateUser(username: String, password: String, response: Binding<APIRequestStatus>) -> Void{
//        
//        ///Send API Request as Single Observable
//        api.sendSingleRequestRx(
//            
//            ///Endpoint to  create a user
//            .createUser(username: username, password: password)).asObservable().subscribe(
//                
//                ///On the next value coming into the observable, bind that to the parameter.
//                onNext: { StatusResponse in
//                    print(StatusResponse)
//                    response.wrappedValue = StatusResponse
//                },
//                
//                onError: { error in
//                    response.wrappedValue = HandleHttpError(error)
//                }
//                
//            ).disposed(by: bag)
//        
//    }
//    

}
