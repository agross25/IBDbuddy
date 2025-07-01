//
//  HomeView.swift
//  IBDbuddy
//
//  Created by Adina Gross on 6/10/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var logManager: LogManager
    // @AppStorage("latestLog") private var latestLogData: Data = Data()
    @State private var mood: Mood = .fine
    
    var body: some View {
        VStack {
            Spacer(minLength: 30) /// Leave space for the notch
            
            ZStack {
                /// Rounded background container
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(red: 1.0, green: 0.74, blue: 0.55).opacity(0.4))
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(radius: 5)
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                    .frame(maxHeight: 670)
                
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
