//
//  ContentView.swift
//  IBDbuddy
//
//  Created by Adina on 6/30/25.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var logManager = LogManager()
    @State var selectedTab = 0
    
    var body: some View {
        // Main tab content
        TabView(selection: $selectedTab) {
            HomeView()
                .background(Color.clear)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            LogView()
                .background(Color.clear)
                .tabItem {
                    Label("Daily Log", systemImage: "checklist")
                }
                .tag(1)
            DataView()
                .background(Color.clear)
                .tabItem {
                    Label("Stats", systemImage: "list.clipboard")
                }
                .tag(2)
        }
        // Inject the manager into every child view:
        .environmentObject(logManager)
    }
}

#Preview {
    ContentView()
}
