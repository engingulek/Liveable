//
//  TabbarRoot.swift
//  Liveable
//
//  Created by engin gülek on 24.09.2023.
//

import SwiftUI

struct TabbarRoot:View {
    @State private var currentTab: String = "Explore"
    
    var body: some View {
        TabView(selection: $currentTab) {
            ExploreView()
                .tag("Explore")
            SavedView()
                .tag("Saved")
            TripsView()
                .tag("Trips")
            InboxView()
                .tag("Inbox")
            
            ProfileView()
                .tag("Profile")
        }.overlay(alignment: .bottom) {
            bottomTabbarStack
        }.ignoresSafeArea(.keyboard, edges: .bottom)
            .padding(.bottom)
    }
}


extension TabbarRoot {
    private var  bottomTabbarStack : some View {
        HStack(spacing:5) {
            TabbarButton(currentTab: $currentTab, title: "Explore", icon: "network")
            TabbarButton(currentTab: $currentTab, title: "Saved", icon: "heart")
            TabbarButton(currentTab: $currentTab, title: "Trips", icon: "location.north")
            TabbarButton(currentTab: $currentTab, title: "Inbox", icon: "message")
            TabbarButton(currentTab: $currentTab, title: "Profile", icon: "person.crop.circle")
        }
    }
}

struct TabbarRoot_Previews: PreviewProvider {
    static var previews: some View {
        TabbarRoot()
    }
}


