//
//  ContentView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
//

import SwiftUI
import SwiftData
import RxSwift
import RxCocoa


struct ContentView: View {
    
    @EnvironmentObject private var psCommonData : psCommonDataClass
    @EnvironmentObject private var psUserData : psUserClass
    @EnvironmentObject private var psCommunityData : psCommunityClass
    @EnvironmentObject private var CommonVM : GeneralVM
    
    @State private var loginStatus : APIResponseCode = APIResponseCode.NotSent
    @State private var doneDisplayingLogo : Bool = false
    @State private var sidebarOpen : Bool = false
    @StateObject var AuthVM: AuthorizationVM

    init() {
        self._AuthVM = StateObject(wrappedValue: AuthorizationVM())
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if AuthVM.autoAuthorizationComplete && doneDisplayingLogo {
                    if AuthVM.isAuthorized {
                        PostLoginViewDecider(CommonVM: CommonVM, psUserData: psUserData, psCommunityData: psCommunityData)
                    } else {
                        LoginView(AuthVM: AuthVM)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 1.0),
                                       value: AuthVM.autoAuthorizationComplete)
                    }
                } else {
                    LogoView()
                        .onAppear{
                            StartLogoViewTimer()
                            self.AuthVM.OnViewOpen(CommonVM: CommonVM, psUserData: psUserData, psCommunityData: psCommunityData)
                            SetupPersistentStorage()
                            
                        }
                    HttpStatusView(statusCode: loginStatus).padding()
                }
            }
        }.background(Color.background)
    }
    
    func SetupPersistentStorage() {
        CommonVM.GetAllCommunities()
        { apiResult in
            psCommonData.allCommunities = apiResult
        }
    }
    
    func StartLogoViewTimer(){
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {
            timer in withAnimation {
                doneDisplayingLogo = true
            }
        }
    }
    
}
