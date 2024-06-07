//
//  TimeElapsedView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/25/24.
//

import SwiftUI

///Displays the time since a given data in a nice format, only displaying the most significant unit
struct TimeElapsedView: View {
    
    private var dateString : String
    var prependText : String = ""
    var suffixText : String = ""
    
    init(date : Date){
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        self.dateString = formatter.string(from: date, to: Date.now)!
        if self.dateString == "0m" {
            self.dateString = "Just Now"
        }
    }
        
    init(prependText: String, suffixText: String, date: Date){
        self.init(date: date)
        self.prependText = prependText
        self.suffixText = suffixText
    }
                
    
    var body: some View {
        rcText(prependText + self.dateString + suffixText).font(.caption)
    }
}
