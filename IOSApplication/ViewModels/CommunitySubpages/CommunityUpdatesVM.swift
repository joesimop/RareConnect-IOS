//
//  CommunityUpdatesVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/17/24.
//

import Foundation
import Combine
import SwiftUI

///View Model for the Community Updates page
class CommunityUpdatesVM : ViewModel {
    
    var community_id: Int           //Current session's community identifier
    var profile_id: Int             //Current session's profile identifier
    
    ///Pulled updates from database
    @Published var communityUpdates: ViewResult<[AbbrArticle]> = ViewResult(defaultValue: [])
    @Published var article: ViewResult<Article> = ViewResult()
    @Published var text: String = "what da heck"
    
    ///API Dispatcher
    private var dispatcher : ViewModelAPIDispatcher = ViewModelAPIDispatcher()
    
    
    init(community_id: Int, profile_id: Int){
        self.community_id = community_id
        self.profile_id = profile_id
        self.OnViewOpen()
    }
    
    ///Gets community updates from backend and set the data
    func OnViewOpen() {
        self.GetCommunityUpdates()
    }
    
    ///Repulls the community updates from the database
    func Refresh() {
        self.communityUpdates.Refresh()
        self.OnViewOpen()
    }
    
    func GetCommunityUpdates(){
        dispatcher.SendRequestViewUpdate(.getCommunityUpdates(community_id: community_id)){ result in
            self.communityUpdates.SetData(result)
        }
    }
    
    func GetArticle(article_id: Int){
        dispatcher.SendRequestViewUpdate(.getArticle(community_id: community_id, article_id: article_id)){ result in
            
        }
    }
    
    func UpdateText(_ t : String){
        self.text = t
    }
}
