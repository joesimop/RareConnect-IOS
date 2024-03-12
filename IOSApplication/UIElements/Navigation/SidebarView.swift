//
//  SidebarView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/30/24.
//

import SwiftUI

///Contains information necessary to compose a sidebar item, including which page to open on click
struct SidebarItem: Identifiable {
    static func == (lhs: SidebarItem, rhs: SidebarItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String
    var image: String
    var content: any View
}

///A list of the sidebar items, with the info necessary to persist user instance
struct SidebarItems {
    
    private var user: psUserClass
    private var community: psCommunityClass
    var items : [SidebarItem]
    
    init(user: psUserClass, community: psCommunityClass) {
        self.user = user
        self.community = community
        
        //All items that are located in the sidebar
        self.items = [
            SidebarItem(name: "Home", image: "Home", content: HomeView(community_id: community.id)),
            SidebarItem(name: "About", image: "Home", content: HomeView(community_id: community.id)),
            SidebarItem(name: "Guidelines", image: "", content: CommunityGuidelinesView(community: community, profile_id: user.id)),
            SidebarItem(name: "Community Updates", image: "", content: HomeView(community: community)),
            SidebarItem(name: "Events", image: "", content: HomeView(community: community)),
            SidebarItem(name: "People", image: "", content: PeopleView(community: community)),
            SidebarItem(name: "Donation", image: "", content: DonationView(community_id: community.id, profile_id: user.id, role: community.role)),
            SidebarItem(name: "Community Board", image: "", content: CommunityBoardView(user: user, psCommunityData: community)),
            SidebarItem(name: "FAQ", image: "", content: FAQView(community: community, profile_id: user.id))
        ]
    }
}

///How each sidebar item looks in the sidebar menu.
///
///Exposes itself to the SideBarView so the parent view knows
///what page to open when one of its children is selected
struct SidebarItemView : View {
    
    var item : SidebarItem
    var SetMainContentView : (SidebarItem) -> Void
    var body: some View {
        ListItem {
            HStack{
                rcText(item.name)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }.onTapGesture {
            SetMainContentView(item)
        }
    }
}
    

///Main control of the sidebar view
///Controls what happens on open and close
struct SidebarView: View {
    
    var user : psUserClass                      // Persistent User Data
    var community : psCommunityClass             // Persistent Community Data
    private var sideBarItems: SidebarItems        // Sidebar item data
    @State var sidebarOpen : Bool = false        // Sidebar open/close state
    @State var selectedView : SidebarItem?        // The view that is currently selected in the sidebar
    
    //Init for a community class to be passed
    init(psCommunityData: psCommunityClass, user: psUserClass) {
        self.community = psCommunityData
        self.user = user
        self.sideBarItems = SidebarItems(user: user, community: psCommunityData)
        self._selectedView = State(initialValue: sideBarItems.items.first!)
    }
    
    //Convientent init for when an AbbrCommunity is passed
    init(psCommunityData: AbbrCommunity, user: psUserClass) {
        self.user = user
        self.community = psCommunityClass()
        self.community.SetCommunity(community: psCommunityData)
        self.sideBarItems = SidebarItems(user: user, community: self.community)
        self._selectedView = State(initialValue: sideBarItems.items.first!)
    }
    
    var SideBar : some View {
        
        // Sidebar
        List{
            ForEach(sideBarItems.items){ item in
                
                //When the item is selected, set the selected view
                //to the SidebarItem selected then close the view
                SidebarItemView(item: item){ selectedItem in
                    selectedView = selectedItem
                    sidebarOpen.toggle()
                }
            }
        }
    }
    
    var body: some View {
            
        ///Controller for displaying two things atop one antother
        ZStack() {
            
            if !sidebarOpen{
                
                ///If we successfully set the newly select view
                if let selectedItem = selectedView {
                    
                    ///AnyView is not ideal, but need it as a layer of abstraction if we just want
                    ///to keep a list of SidebarItem that automatically populates
                    AnyView(selectedItem.content)
                    
                    ///Commonalities between all pages that are shared
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle(selectedItem.name)
                        .transition(.move(edge: .trailing))
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button() {
                                    withAnimation {
                                        sidebarOpen.toggle()
                                    }
                                } label: {
                                    Text("Menu")
                                }
                        }
                    }
                } else {
                    rcText("Could not bind views. Please relaunch app.")
                }
               
            }
            
            ///Display Sidebar if it is toggled to open
            else {
                SideBar.transition(.move(edge: .leading))
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Menu")
            }
            
        }
        .animation(.easeInOut, value: sidebarOpen)
        
    }
}
