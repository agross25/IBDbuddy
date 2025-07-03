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
//            LogView()
//                .background(Color.clear)
//                .tabItem {
//                    Label("Daily Log", systemImage: "list.clipboard")
//                }
//                .tag(1)
            MindView()
                .background(Color.clear)
                .tabItem {
                    Label("Mind", systemImage: "brain")
                }
                .tag(1)
            BodyView()
                .background(Color.clear)
                .tabItem {
                    Label("Body", systemImage: "figure.run")
                }
                .tag(2)
            DataView()
                .background(Color.clear)
                .tabItem {
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
                .tag(3)
            BadgeView()
                .background(Color.clear)
                .tabItem {
                    Label("Achievements", systemImage: "trophy")
                }
                .tag(4)
        }
        // Inject the manager into every child view:
        .environmentObject(logManager)
        .accentColor(Color(red: 1.0, green: 0.5, blue: 0.4))
    }
}

#Preview {
    ContentView()
}
