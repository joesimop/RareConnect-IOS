//
//  APIResponseDisplay.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/12/24.
//

import SwiftUI

struct APIResponseDisplay: View {
    
    @State var data : PossibleAPIData
    
    var body: some View {
        switch data {
        case .responseCode(let APIResponseCode):
            HttpStatusView(statusCode: APIResponseCode)
        case .jsonObject(_):
            Text("JsonObject")
        case .unknown:
            Text("Recieved Unknown Response")
        }
    }
}
