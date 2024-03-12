//
//  RequestStatusView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/24/24.
//

import SwiftUI

///Displays the status for a community request
struct RequestStatusView: View {
    
    var status : eRequestStatus
    
    var body: some View {
        switch status {
        case .Pending:
            Text("Pending")
                .foregroundStyle(Color.black)
                .background(Color.gray)
        case .Accepted:
            Text("Accepted")
                .foregroundStyle(Color.green).bold()
        case .Rejected:
            Text("Rejected")
                .foregroundStyle(Color.red).bold()
        }
    }
}

