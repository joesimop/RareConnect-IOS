//
//  AdminVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 5/20/24.
//

import Foundation

///View Model for the Admin page
class AdminVM : ViewModel {
    
    var community_id: Int = 0           //Current session's community identifier
    var profile_id: Int = 0            //Current session's profile identifier
    
    ///Pulled Notifications from database
    @Published var Notifications: ViewResult<[AdminNotification]> = ViewResult(defaultValue: [])
    
    ///API Dispatcher
    private var dispatcher : ViewModelAPIDispatcher = ViewModelAPIDispatcher()
    
    func Initialize(community_id: Int, profile_id: Int){
        self.community_id = community_id
        self.profile_id = profile_id
        self.OnViewOpen()
    }
    
    func OnViewOpen() {
        dispatcher.SendRequestViewUpdate(.getAdminNotifications(community_id: community_id)){ result in
            self.Notifications.SetData(result)
        }
    }
    
    func Refresh() {
        self.Notifications.Refresh()
        self.OnViewOpen()
    }
    
    func AllowPost(notification_id: Int, allow_post: Bool) {
        dispatcher.SendRequestViewUpdate(.permitFlaggedPost(community_id: community_id, notification_id: notification_id, allow_post: allow_post)) {_ in
            self.Notifications.data?.removeAll(where: {$0.id == notification_id})
            self.objectWillChange.send()
        }
    }
}
