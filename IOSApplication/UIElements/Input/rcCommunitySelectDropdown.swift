//
//  rcCommunitySelectDropdown.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/23/24.
//

import SwiftUI

struct rcCommunitySelectDropdown: View {
    
    @EnvironmentObject var psCommonData : psCommonDataClass
    @Binding var selectedCommunity: Int

    var body: some View {
        VStack {
            HStack{
                rcText("Select a Community: ").bold()
                Picker("Select a Community: ", selection: $selectedCommunity) {
                    ForEach(psCommonData.allCommunities, id: \.self) { community in
                        Text(community.name).tag(community.id)
                    }
                }
                .pickerStyle(.menu)
                .overlay(rcUnderlineOverlay(underlineColor: .textPrimary))
            }.padding()
        }.onAppear(){
            selectedCommunity = psCommonData.allCommunities[0].id
        }
    }
}
