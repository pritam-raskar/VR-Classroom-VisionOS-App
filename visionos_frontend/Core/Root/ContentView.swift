//
//  ContentView.swift
//  visionos_frontend
//
//  Created by Abir Pal on 07/10/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "square.grid.2x2")
                }
                .tag(1)
            
            InstructorLiveClassView()
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
                .tag(2)
            
            
            
            UserSettingView()
                .tabItem {
                    Label("Setting", systemImage: "person.fill")
                }
                .tag(3)
        }
    }
}

#Preview(windowStyle: .plain) {
    NavigationStack {
        ContentView()
    }
}


