//
//  IOSApplicationApp.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
//

import SwiftUI
import SwiftData


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var profile_id : Int = 0
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        if self.profile_id != 0 {
            api.sendSingleRequestRx(.logout(profile_id: self.profile_id))
        } else{
            print("Could not logout")
        }
        
    }
}

@main
struct RareConnectApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    var api = APICaller()
    @StateObject var AuthVM = AuthorizationClass()
    @StateObject var AppState = AppStateClass()
    @StateObject var CommonVM = GeneralVM()
    @StateObject var CommonData = psCommonDataClass()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthVM)
                .environmentObject(AppState)
                .environmentObject(CommonVM)
                .environmentObject(CommonData)
                .environment(\.font, Font.custom("Helvetica", size: 14))
        }
//        .onChange(of: scenePhase) { (oldPhase, newPhase) in
//            
//            switch newPhase {
//            case .background:
//                await Task.detached(priority: .background){
//                    api.sendSingleRequestRx(
//                        .log_app_close(profile_id: AppState.user.id, community_id: AppState.community.id))
//                }
//            
//            case .inactive:
//                print("inactive")
//            case .active:
//                print("active")
//            @unknown default:
//                print("New phase")
//            }
//        }
    }
}
