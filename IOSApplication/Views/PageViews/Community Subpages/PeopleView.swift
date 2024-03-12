//
//  PeopleView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/28/24.
//

import SwiftUI

struct PeopleView: View {
    
    var searchPrompt : String
    var community: psCommunityClass
    @State private var request : SearchAPIRequest<[AbbrProfile]>
    
    init(community: psCommunityClass) {
        self.community = community
        self.request = .searchProfiles(community_id: community.id)
        self.searchPrompt = "Search profiles in the " + community.name + " community."
    }
    
    var body: some View {
        
        rcDatabaseSearch(request: request, searchPrompt: searchPrompt){ person in
            NavigationLink(destination: ProfileView(community_id: community.id, profile_id: person.id)) {
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            rcText(person.firstname + " " + person.lastname)
                            rcSubText(person.username)
                        }
                        rcText(person.role.rawValue.capitalized, color: IsAdmin(person.role) ? .success : .textPrimary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.textPrimary)
                    
                }
               
            }
        }
    }
}

