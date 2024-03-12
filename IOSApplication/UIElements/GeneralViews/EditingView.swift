//
//  EditingView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/8/24.
//

import SwiftUI

///A view to handle logic for what to display for editable objects
struct EditingView<NotEditing : View, Editing : View> : View {
    
    var NotEditingContent : () -> NotEditing        //What is displayed when not editing
    var EditingContent : () -> Editing             //What is displayed while editing.
    var completion : () -> Void                    //A function that is exectuted once editing is done.
    @State private var isEditing : Bool = false       //If the user is currently editing.
    
    var body: some View {
        if isEditing {
            VStack{
                EditingContent()
                Spacer()
                rcButton(text: "Done", fillWidth: true){
                    completion()
                    isEditing.toggle()
                }
            }
            
        } else {
            NotEditingContent()
                .onTapGesture {
                    isEditing.toggle()
                }
        }
    }
}
