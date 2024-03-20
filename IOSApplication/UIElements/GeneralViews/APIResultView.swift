//
//  APIResultView2.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/1/24.
//

import SwiftUI

///Handles logic for displaying the result of API calls
struct APIResultView<Content : View, T>: View {
        
        @Binding var apiResult : ViewResult<T>      //Actual data being displayed
        var successDisplay : (T) -> Content       //What to display if suscessful
        
        //What to display if we have an object, are waiting, or get a code back.
        var body: some View {
            switch apiResult.state{
            case .object:
                successDisplay(apiResult.data!)
            case .loading:
                ProgressView("Loading...")
               
            case .code(let code):
                HttpStatusView(statusCode: code)
            }
        }
}
