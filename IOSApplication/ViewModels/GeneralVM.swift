//
//  GeneralVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/18/24.
//

import Foundation
import SwiftUI
import RxSwift

typealias CompletionHandler<T> = (T) -> Void
let api = APICaller()

///View Model for API Calls that are used once or don't fit into a specfic View Model
class GeneralVM : ObservableObject {
    
    var bag = DisposeBag()
    
    ///Get all communities in the database
    func GetAllCommunities(completion: @escaping CompletionHandler<[Community]>){
        api.sendSingleRequestRx(.getAllCommunities())
            .CompletionHandler(action: completion, bag: bag)
            
    }
    
    ///Gets a user's profile by their username
    func GetUserByUsername(username : String, completion: @escaping CompletionHandler<UserProfile>){
        api.sendSingleRequestRx(.getProfileByUsername(username: username))
            .CompletionHandler(action: completion, bag: bag)
    }
    
//    func GetCommunityProfile(community_id: Int, profile_id: Int, binding: Binding<ViewResult<UserProfile>>) {
//        api.sendSingleRequestRx(.getCommunityProfile(community_id: community_id, profile_id: profile_id))
//            .asObservable()
//            .BindViewResult(binding: binding)
//            .disposed(by: bag)
//    }
    
    
    ///Gets communities that a profile is apart of
    func GetCommunitiesForProfile(profile_id : Int, completion: @escaping CompletionHandler<[AbbrCommunity]>){
        api.sendSingleRequestRx(.getCommunitiesForProfile(profile_id: profile_id))
            .CompletionHandler(action: completion, bag: bag)
    }
    
    ///Submits a request to join a community
    func SubmitCommunityRequest(community_id: Int, request: CommunityRequestBody, binding: Binding<APIResponseCode>){
        api.sendSingleRequestRx(.submitCommunityRequest(community_id: community_id, request: request))
            .asObservable()
            .BindValue(binding: binding)
            .disposed(by: bag)
    }
    
    ///Submits a request to create a community
    func SubmitCommunityApplication(application: CommunityApplicationBody, response: Binding<APIResponseCode>) {
        api.sendSingleRequestRx(.submitCommunityApplication(application: application))
            .asObservable()
            .BindValue(binding: response)
            .disposed(by: bag)
    }
    
    ///Gets the community requests of a profile.
    func GetCommunityRequests(profile_id: Int, completion: @escaping CompletionHandler<[CommunityRequest]>) {
        api.sendSingleRequestRx(.getCommunityRequests(profile_id: profile_id))
            .CompletionHandler(action: completion, bag: bag)
    }
    
}


