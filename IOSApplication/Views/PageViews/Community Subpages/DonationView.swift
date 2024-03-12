//
//  DonationView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/12/24.
//

import SwiftUI
import CurrencyField

struct DonationView: View {
    
    var community_id: Int
    var role : eRole
    @State var amount : Int
    @State var editableMessage = ""
    @StateObject var VM: DonationVM
    
    init(community_id: Int, profile_id: Int, role: eRole){
        self.community_id = community_id
        self.role = role
        self._VM = StateObject(wrappedValue: DonationVM(community_id: community_id, profile_id: profile_id))
        self.amount = 0
    }
    
    var body: some View {
        
        EditableView(userRole: role) { inEditMode in
            APIResultView(apiResult: $VM.page) { pageInfo in
                VStack(alignment: .center) {
                    if inEditMode.wrappedValue {
                        EditingView(
                            NotEditingContent: {
                                VStack{
                                    rcEditableText(text: pageInfo.message, inEditMode: inEditMode)
                                }
                            },
                            EditingContent: {
                                rcTextField(text: $editableMessage)
                            }, completion: {
                                print("Done")
                            }
                        )
                    } else {
                        rcText(pageInfo.message)
                    }
                }
            }
        }
    }
}
