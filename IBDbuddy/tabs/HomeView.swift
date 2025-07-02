//
//  HomeView.swift
//  IBDbuddy
//
//  Created by Adina Gross on 6/10/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var logManager: LogManager
    @State private var mood: Mood = .fine
    
    var body: some View {
        ZStack {
            // Background color fills entire screen
            Color(red: 1.0, green: 0.74, blue: 0.55).opacity(0.5).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header at the top
                Text("Your IBD Buddy")
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1.0, green: 0.74, blue: 0.55).opacity(0.2))
                    .shadow(radius: 3)

                Spacer()
            
                // 🧍 Avatar Display
                VStack(spacing: 16) {
                    Image(mood.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text("Buddy is feeling \(mood.rawValue) today!").font(.headline)
                }
                .padding()
            }
            Spacer()
        }
        .onAppear {
            // Pull the very last log, if any, otherwise default mood:
            if let lastLog = logManager.logs.last {
                mood = lastLog.mood
            } else {
                mood = .fine
            }
        }
       
        // Also respond live to new logs:
        .onChange(of: logManager.logs) { _ in
            if let lastLog = logManager.logs.last {
                withAnimation {
                    mood = lastLog.mood
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LogManager())
}
