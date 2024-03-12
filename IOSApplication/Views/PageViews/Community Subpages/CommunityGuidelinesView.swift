//
//  CommunityGuidelinesView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/3/24.
//

import SwiftUI

struct CommunityGuidelinesView: View {

    var psCommunityData : psCommunityClass
    @State private var newGuideline : String = ""
    @StateObject private var VM : GuidelinesVM
    
    init(community : psCommunityClass, profile_id: Int) {
        self.psCommunityData = community
        self._VM = StateObject(wrappedValue: GuidelinesVM(community_id: community.id, profile_id: profile_id))
    }
    
    var body: some View {
        
        EditableView(userRole: psCommunityData.role){ inEditMode in
            
            VStack{
                rcText("Welcome to our community guidelines! These rules ensure a safe, respectful environment for individuals with rare and orphan diseases, fostering supportive connections. By following these guidelines, we maintain a positive atmosphere where everyone feels valued and heard.")
                
                APIResultView(apiResult: $VM.guidelines){ guidelines in
                    
                    List {
                        ForEach(Array(guidelines.enumerated()), id: \.element) { index, guideline in
                            HStack(alignment: .top) {
                                rcText("\(index + 1).)")
                                rcText(guideline.text)
                            }
                            
                        }
                        .onDelete { indexSet in
                            VM.DeleteGuideline(indexSet)
                        }
                        .onMove{ fromOffsets, newOffset in
                            VM.ReorderGuidelines(fromOffsets, newOffset)
                        }
                        if inEditMode.wrappedValue {
                            
                            EditingView(
                                NotEditingContent: {
                                    HStack{
                                        Image(systemName: "plus")
                                        rcText("New Guideline")
                                    }
                                },
                                EditingContent: {
                                    HStack{
                                        rcText("\(guidelines.count + 1).) ")
                                        rcTextInput(prompt: "New Guideline", bindTo: $newGuideline)
                                    }
                                }, completion: {
                                    VM.CreateGuidline(orderNumber: guidelines.count + 1, text: newGuideline)
                                }
                            )
                        }
                    }.listStyle(.inset)
                }
            }
        }.onAppear{
            self.VM.OnViewOpen()
        }
    }
}
