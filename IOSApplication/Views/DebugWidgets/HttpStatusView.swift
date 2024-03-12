//
//  HttpStatusView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/4/23.
//

import Foundation
import SwiftUI

struct HttpStatusView: View {
    
    let statusCode: APIResponseCode

    var body: some View {
        VStack {
            switch statusCode {
                case .Success( _ ):
                    Text(statusCode.description)
                        .foregroundStyle(.green)
                case .Error( _ ):
                    Text(statusCode.description)
                        .foregroundStyle(.red)
                case .Waiting:
                    Text(statusCode.description)
                        .foregroundStyle(.yellow)
            default: Text("")
                
                }
        }
        .font(.caption)
        .bold()
        .padding()
        .font(.system(size: 12))
    }
}
