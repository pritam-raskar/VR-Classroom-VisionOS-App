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
                    Label("Browser", systemImage: "command")
                }
                .tag(0)
            
            UserSettingView()
                .tabItem {
                    Label("Setting", systemImage: "gearshape")
                }.tag(1)
            
            Text("Photo1")
                .tabItem {
                    Label("Courses", systemImage: "photo.on.rectangle")
                }.tag(2)
            
            Text("Photo2")
                .tabItem {
                    Label("Favorite", systemImage: "rectangle.stack.fill")
                }.tag(3)
            
            Text("Photo3")
                .tabItem {
                    Label("Immersive Experience", systemImage: "pano.fill")
                }.tag(4)
            
            Text("Photo4")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }.tag(4)
        }
    }
}

#Preview(windowStyle: .plain) {
    NavigationStack {
        ContentView()
    }
}


