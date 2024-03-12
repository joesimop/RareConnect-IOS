//
//  DonationVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/12/24.
//

import Foundation
import SwiftUI

///View Model for Donation Page
class DonationVM : ViewModel {
    
    var community_id: Int
    var profile_id: Int
    @Published var page: ViewResult = ViewResult(defaultValue: DonationPage(message: "Default Message"))
    private var dispatcher = ViewModelAPIDispatcher()
    
    init(community_id: Int, profile_id: Int) {
        self.community_id = community_id
        self.profile_id = profile_id
        self.OnViewOpen()
    }
    
    func Refresh() {
        self.page.Refresh()
        self.OnViewOpen()
    }
    func OnViewOpen() {
        self.GetPage()
    }
    func GetPage(){
        dispatcher.SendRequestViewUpdate(.getDonationPage(community_id: community_id)) { data in
            self.page.SetData(data)
        }
    }
    
}
