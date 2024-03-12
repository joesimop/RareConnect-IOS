//
//  rcQuestionPrompt.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/24/24.
//

import SwiftUI

struct rcQuestionPrompt: View {
    
    let question: String
    let placeHolderText: String = ""
    @Binding var response: String

    var body: some View {
        VStack(alignment: .leading) {
            
            rcText(question)
                .bold()
                .foregroundColor(Color.textPrimary)
            ZStack{
                TextEditor(text: $response)
                    .frame(height: 80)
                    .cornerRadius(15)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.grey, lineWidth: 1)
                    .frame(height: 80)
            }
            

        }
        .padding()
        
    }
}

