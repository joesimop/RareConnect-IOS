//
//  IOSApplicationApp.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
//

import SwiftUI
import SwiftData


@main
struct RareConnectApp: App {
    
    var api = APICaller()
    @StateObject var CommonVM = GeneralVM()
    @StateObject var psCommonData = psCommonDataClass()
    @StateObject var psUserData = psUserClass()
    @StateObject var psCommunityData = psCommunityClass()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CommonVM)
                .environmentObject(psCommonData)
                .environmentObject(psUserData)
                .environmentObject(psCommunityData)	
                .environment(\.font, Font.custom("Helvetica", size: 14))
        }
    }
}
