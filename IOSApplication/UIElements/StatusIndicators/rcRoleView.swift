//
//  rcRoleView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/1/24.
//

import SwiftUI

///Displays the role of a profile within a community.
struct rcRoleView: View {
    
    var role : eRole
    
    init(_ role: eRole) {
        self.role = role
    }
    
    var body: some View {
        if(role == .Admin){
            rcText("Admin", color: .success).bold()
        } else {
            rcText("Member", color: .textPrimary).bold()
        }
    }
}
