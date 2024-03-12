//
//  StandardView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/8/24.
//

import SwiftUI

struct EditableView<V : View> : View {
    
    var userRole : eRole = .NoCredentials
    var content : (Binding<Bool>) -> V
    @State private var isEditing : Bool = false
    var body: some View {
        content($isEditing)
            .padding()
            .toolbar {
                if(IsAdmin(userRole)){
                    EditButton().simultaneousGesture(TapGesture().onEnded{
                        isEditing.toggle()
                    })
                }
            }
    }
}
