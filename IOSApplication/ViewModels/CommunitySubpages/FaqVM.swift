//
//  GuidelinesVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/3/24.
//

import Foundation
import SwiftUI

///View Model for the FAQ page
class FaqVM : ViewModel {
    
    var community_id: Int           //Current session's community identifier
    var profile_id: Int             //Current session's profile identifier
    
    ///Pulled FAQS from database
    @Published var FAQs: ViewResult<[FAQ]> = ViewResult(defaultValue: [])
    
    ///API Dispatcher
    private var dispatcher : ViewModelAPIDispatcher = ViewModelAPIDispatcher()
    
    init(community_id: Int, profile_id: Int){
        self.community_id = community_id
        self.profile_id = profile_id
        self.OnViewOpen()
    }
    
    ///Gets guidelines from backend and set the data
    func OnViewOpen() {
        dispatcher.SendRequestViewUpdate(.getFAQs(community_id: community_id)){ result in
            self.FAQs.SetData(result)
        }
    }
    
    ///Repulls the guidelines from the database
    func Refresh() {
        self.FAQs.Refresh()
        self.OnViewOpen()
    }

    ///Reorders guidelines in backend then, if successful, reorders it in model.
    func ReorderFAQs(_ fromOffsets : IndexSet, _ toOffset : Int){
        
        //Conversions from Swift's List system to mine
        let oldOffset = fromOffsets.first! + 1
        let faq_id = self.FAQs.data![oldOffset - 1].id
        let newOffset = toOffset > oldOffset ? toOffset : toOffset + 1
        
        //Dispatch API Call
        dispatcher.SendRequestViewUpdate(.reorderFAQ(community_id: community_id, faqId: faq_id!, fromOffset: oldOffset, toOffset: newOffset)) { apiResult in
            if IsSuccessful(apiResult) {
                self.FAQs.data!.move(fromOffsets: fromOffsets, toOffset: toOffset)
            }
        }
    }
    
    ///Deletes a guideline and removes the respective one from model
    func DeleteFAQ(_ offsets: IndexSet){
        let index = offsets.first!
        let id = self.FAQs.data![index].id
        dispatcher.SendRequestViewUpdate(.deleteFAQ(community_id: community_id, faqId: id!)){ result in
            if IsSuccessful(result) {
                self.FAQs.data!.remove(at: index)
            }
        }
    }
    
    ///Creates a guideline and adds it model
    func SubmitFAQ(newFAQ: FAQ) {
        dispatcher.SendRequestViewUpdate(.submitFAQ(community_id: community_id, newFaq: newFAQ)){
            result in
            if(IsSuccessful(result)){
                //Right now just generate random int. Need to get id from database
                self.FAQs.data!.append(FAQ(id: Int.random(in: -1000...0), order_number: newFAQ.order_number, question: newFAQ.question, answer: newFAQ.answer))
            }
        }
    }
}
