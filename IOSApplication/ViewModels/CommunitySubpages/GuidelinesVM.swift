//
//  GuidelinesVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/3/24.
//

import Foundation
import SwiftUI

///View Model for the Community Guidelines page
class GuidelinesVM : ViewModel {
    
    var community_id: Int           //Current session's community identifier
    var profile_id: Int             //Current session's profile identifier
    
    ///Pulled guidwlines from database
    @Published var guidelines: ViewResult<[Guideline]> = ViewResult(defaultValue: [])
    
    ///API Dispatcher
    private var dispatcher : ViewModelAPIDispatcher = ViewModelAPIDispatcher()
    
    init(community_id: Int, profile_id: Int){
        self.community_id = community_id
        self.profile_id = profile_id
        //self.OnViewOpen()
    }
    
    ///Gets guidelines from backend and set the data
    func OnViewOpen() {
        dispatcher.SendRequestViewUpdate(.getCommunityGuidlines(community_id: community_id)){ result in
            self.guidelines.SetData(result)
        }
    }
    
    ///Repulls the guidelines from the database
    func Refresh() {
        self.guidelines.Refresh()
        self.OnViewOpen()
    }

    ///Reorders guidelines in backend then, if successful, reorders it in model.
    func ReorderGuidelines(_ fromOffsets : IndexSet, _ toOffset : Int){
        
        //Conversions from Swift's List system to mine
        let oldOffset = fromOffsets.first! + 1
        let guideline_id = self.guidelines.data![oldOffset - 1].id
        let newOffset = toOffset > oldOffset ? toOffset : toOffset + 1
        
        //Dispatch API Call
        dispatcher.SendRequestViewUpdate(.reOrderGuidelines(community_id: community_id, guideline_id: guideline_id, fromOffset: oldOffset, toOffset: newOffset)) { apiResult in
            if IsSuccessful(apiResult) {
                self.guidelines.data!.move(fromOffsets: fromOffsets, toOffset: toOffset)
            }
        }
    }
    
    ///Deletes a guideline and removes the respective one from model
    func DeleteGuideline(_ offsets: IndexSet){
        let index = offsets.first!
        let id = self.guidelines.data![index].id
        dispatcher.SendRequestViewUpdate(.deleteGuideline(community_id: community_id, guideline_id: id)){ result in
            if IsSuccessful(result) {
                self.guidelines.data!.remove(at: index)
            }
        }
    }
    
    ///Creates a guideline and adds it model
    func CreateGuidline(orderNumber: Int, text: String) {
        dispatcher.SendRequestViewUpdate(.createGuideline(community_id: community_id, orderNumber: orderNumber, text: text)){
            result in
            if(IsSuccessful(result)){
                //Right now just generate random int. Need to get id from database
                self.guidelines.data!.append(Guideline(id: Int.random(in: -1000...0), order_number: self.guidelines.data!.count + 1, text: text))
            }
        }
    }
    
}
