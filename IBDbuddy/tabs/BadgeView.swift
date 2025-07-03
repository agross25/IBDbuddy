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
                Text("Your Achievements")
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
