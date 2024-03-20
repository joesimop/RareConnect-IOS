//
//  CreateArticle.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/18/24.
//

import SwiftUI

struct CreateArticleView: View {
    
    @State private var title : String = ""
    @State private var selectedArticleType : eArticleType = .PDF
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: VSTACK_SPACING) {
            
            rcHeadline("Create New Update")
            rcTextInput(prompt: "Title", bindTo: $title)
            
            Picker("ArticleType", selection: $selectedArticleType) {
                ForEach(eArticleType.allCases, id: \.self) { option in
                    Text(option.rawValue.uppercased()).tag(option)
                }
            }
            .pickerStyle(.palette)
            .padding()
            
            switch selectedArticleType {
            case .PDF:
                rcText("PDF")
            case .HTML:
                rcText("HTML")
            case .Text:
                rcText("TEXT")
            }
            
            Spacer()
        }
        
        
    }
}
