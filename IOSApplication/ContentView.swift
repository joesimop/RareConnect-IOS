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
    @EnvironmentObject private var CommonVM : GeneralVM
    @EnvironmentObject private var AuthVM : AuthorizationClass
    @EnvironmentObject private var AppState : AppStateClass
    
    @State private var loginStatus : APIResponseCode = APIResponseCode.NotSent
    @State private var doneDisplayingLogo : Bool = false
    
    var body: some View {
        
        VStack{
            if doneDisplayingLogo && AuthVM.isAuthorized {
                NavigationStack {
                    PostLoginViewDecider(AppState: AppState, CommonVM: CommonVM)
                }
            } else {
                LogoView()
                    .onAppear{
                        StartLogoViewTimer()
                        AuthVM.OnViewOpen(){ authorizedUsername in
                            AppState.SetupApplicationState(username: authorizedUsername){
                                AuthVM.AutoAuthorizeValidated()
                            }
                        }
                        SetupPersistentStorage()
                    }
            }
        }.fullScreenCover(isPresented: $AuthVM.showLogin){
            NavigationStack{
                LoginView(AppState: AppState, AuthVM: AuthVM, CommonVM: CommonVM)
            }
        }
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
