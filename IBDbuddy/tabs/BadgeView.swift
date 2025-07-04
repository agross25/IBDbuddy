//
//  BadgeView.swift
//  IBDbuddy
//
//  Created by Adina on 7/3/25.
//
import SwiftUI

struct BadgeView: View {
    
    var body: some View {
        ZStack {
            // Background color fills entire screen
            Color(red: 1.0, green: 0.74, blue: 0.55).opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header fixed at the top
                Text("Your Badges")
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1.0, green: 0.9, blue: 0.8))
                    .shadow(radius: 3)
            
                Spacer(minLength: 25)
                                
                Text("Take a look at what you've accomplished!").font(.headline)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 5)
                Text("Keep meeting goals to earn more badges!").font(.subheadline)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        BadgeCard(title: "Log 7 Days in a Row", progress: 3, goal: 7, icon: "star.fill")
                        BadgeCard(title: "Exercise 5 Times This Week", progress: 2, goal: 5, icon: "figure.run")
                        BadgeCard(title: "Eat Under 2000 Calories for 3 Days", progress: 1, goal: 3, icon: "fork.knife")
                        BadgeCard(title: "Listen to 5 Guided Meditations", progress: 3, goal: 5, icon: "airpods")
                        BadgeCard(title: "Make Buddy Happy for 3 Consecutive Days", progress: 3, goal: 3, icon: "face.smiling")
                        BadgeCard(title: "Take 6,000 Daily Steps for 7 Days", progress: 4, goal: 7, icon: "shoeprints.fill")
                        BadgeCard(title: "Opt In for Notifications", progress: 1, goal: 1, icon: "message.badge")
                    }
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 10) // space above tab bar
       
    }
}

#Preview {
    BadgeView()
}


