//
//  FAQView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/9/24.
//

import SwiftUI

struct FAQView: View {
    
    var psCommunityData : psCommunityClass
    @State private var newQuestion: String = ""
    @State private var newAnswer: String = ""
    @StateObject private var VM : FaqVM
    
    init(community : psCommunityClass, profile_id: Int) {
        self.psCommunityData = community
        self._VM = StateObject(wrappedValue: FaqVM(community_id: community.id, profile_id: profile_id))
    }
    
    var body: some View {
        
        EditableView(userRole: psCommunityData.role){ inEditMode in
            
            VStack{
                rcText("Discover our Rare and Orphan Disease FAQ page, a crucial hub for understanding your journey. Here, you'll find concise answers about symptoms, treatments, and the latest research, fostering a community where information empowers and connects us all.")
                
                APIResultView(apiResult: $VM.FAQs){ faqs in
                    
                    List {
                        ForEach(Array(faqs.enumerated()), id: \.element) { index, faq in
                            rcDropdown(headerText: "\(index + 1).) \(faq.question)") {
                                rcText(faq.answer)
                            }.listRowSeparator(.hidden)
                                .listRowInsets(.none)
                            
                        }
                        .onDelete { indexSet in
                            VM.DeleteFAQ(indexSet)
                        }
                        .onMove{ fromOffsets, newOffset in
                            VM.ReorderFAQs(fromOffsets, newOffset)
                        }
                        if inEditMode.wrappedValue {
                            
                            EditingView(
                                NotEditingContent: {
                                    HStack{
                                        Image(systemName: "plus")
                                        rcText("New FAQ")
                                    }
                                },
                                EditingContent: {
                                    VStack{
                                        HStack{
                                            rcText("\(faqs.count + 1).) ")
                                            rcTextInput(prompt: "Question", bindTo: $newQuestion)
                                        }
                                        rcTextInput(prompt: "Answer", bindTo: $newAnswer)
                                    }
                                    
                                }, completion: {
                                    let newFAQ = FAQ(id: nil, order_number: faqs.count + 1, question: newQuestion, answer: newAnswer)
                                    VM.SubmitFAQ(newFAQ: newFAQ)
                                }
                            )
                        }
                    }.listStyle(.plain)
                }
            }
        }
    }
}
