//
//  BadgeCard.swift
//  IBDbuddy
//
//  Created by Adina on 7/4/25.
//
import SwiftUI

struct BadgeCard: View {
    let title: String
    let progress: Int
    let goal: Int
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.orange)
                Text(title)
                    .font(.headline)
                
                Spacer()

                // Display green badge icon if goal is reached
                if progress >= goal {
                    Image(systemName: "checkmark.seal.fill").foregroundColor(.green).font(.title)
                }
            }

            ProgressView(value: Double(progress), total: Double(goal))
                .progressViewStyle(LinearProgressViewStyle(tint: .orange))
            
            Text("\(progress)/\(goal) completed")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(15)
        .shadow(radius: 4)
    }
}

