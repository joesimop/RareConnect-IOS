//
//  ErrorDisplay.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/6/24.
//

import SwiftUI

///Display an Error
struct ErrorDisplay: View {
    
    let error: APIResponseCode.APIError

    var body: some View {
        Text(error.localizedDescription)
            .foregroundStyle(.red)
            .font(.caption)
            .bold()
            .padding()
            .font(.system(size: 12))
    }
}
