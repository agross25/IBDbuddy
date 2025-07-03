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
    @State private var showLogView = false
    
    var body: some View {
        ZStack {
            // Background color fills entire screen
            Color(red: 1.0, green: 0.74, blue: 0.55).opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header fixed at the top
                Text("Your IBD Buddy")
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1.0, green: 0.9, blue: 0.8))
                    .shadow(radius: 3)

                Spacer()
            
                // Avatar Display
                VStack(spacing: 16) {
                    
                    Text("Welcome Back!")
                        .font(.title2)
                    
                    Image(mood.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text("Buddy is feeling \(mood.rawValue) today!").font(.headline)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Spacer()
                
                // Logging Section
                VStack(spacing: 12) {
                    // Save Log Button
                    Button("Go To Daily Log") {
                        showLogView = true
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(logManager.didLogToday)
                    .accentColor(.orange.opacity(0.8))
                    .opacity(0.8)
                    .bold()

                    // Message
                    if logManager.didLogToday {
                        Text("Thank you for logging today!")
                            .foregroundColor(.green)
                    } else if let days = logManager.daysSinceLastLog {
                        Text("It has been \(days) day\(days == 1 ? "" : "s") since your last log.")
                            .foregroundColor(.orange)
                    }

                    // Reset (optional, for testing)
                    Button("🔄 Reset Log Status") {
                        logManager.resetTodayStatus()
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
                Spacer()
            }
        }
        .padding(.bottom, 10) // space above tab bar
        // Display appropriate mood based on last log, otherwise default
        .onAppear {
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
        // Display LogView when 'Save Log' button is pressed
        .sheet(isPresented: $showLogView) {
            LogView()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LogManager())
}
