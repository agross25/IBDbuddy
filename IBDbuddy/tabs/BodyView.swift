//
//  BodyView.swift
//  IBDbuddy
//
//  Created by Adina on 7/3/25.
//
import SwiftUI

struct BodyVideo: Identifiable {
    let id = UUID()
    let title: String
    let thumbnailName: String // matches an image in Assets
    let youtubeURL: URL
}

struct BodyView: View {
    // Video data
    let videos = [
        BodyVideo(title: "20 Min Cardio HIIT", thumbnailName: "workout1", youtubeURL: URL(string: "https://www.youtube.com/watch?v=FeR-4_Opt-g")!),
        BodyVideo(title: "30 Min Cardio HIIT", thumbnailName: "workout2", youtubeURL: URL(string: "https://www.youtube.com/watch?v=n_cIBBDb9JA")!),
        BodyVideo(title: "20 Min Step to the Beat", thumbnailName: "workout3", youtubeURL: URL(string: "https://www.youtube.com/watch?v=y3KwVF-aBNQ")!),
        BodyVideo(title: "30 Min Full Body Strength", thumbnailName: "workout4", youtubeURL: URL(string: "https://www.youtube.com/watch?v=9FBIaqr7TjQ")!),
        BodyVideo(title: "20 Min Bodyweight Strength", thumbnailName: "workout5", youtubeURL: URL(string: "https://www.youtube.com/watch?v=UjwKKl157hw")!),
        BodyVideo(title: "30 Min Full Body Dumbell", thumbnailName: "workout6", youtubeURL: URL(string: "https://www.youtube.com/watch?v=J0vYrFI4S6E")!),
        BodyVideo(title: "15 Min Pilates", thumbnailName: "workout7", youtubeURL: URL(string: "https://www.youtube.com/watch?v=ZfCx3N5MG04")!),
        BodyVideo(title: "10 Min Low Impact Cardio", thumbnailName: "workout8", youtubeURL: URL(string: "https://www.youtube.com/watch?v=4_b9rWBrvrM")!),
        BodyVideo(title: "5 Min Power Abs", thumbnailName: "workout9", youtubeURL: URL(string: "https://www.youtube.com/watch?v=FHjxgyzJXPw")!),
        BodyVideo(title: "5 Min Arm Workout", thumbnailName: "workout10", youtubeURL: URL(string: "https://www.youtube.com/watch?v=oQDqwErnVxU")!),
        BodyVideo(title: "15 Min Ab Blast Workout", thumbnailName: "workout11", youtubeURL: URL(string: "https://www.youtube.com/watch?v=uXZEuSuLfJU")!),
        BodyVideo(title: "10 Min Barre, Dance, and Strength", thumbnailName: "workout12", youtubeURL: URL(string: "https://www.youtube.com/watch?v=4hD-HnCjYcE")!)
    ]
    
    // Grid layout
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ZStack {
            // Background color fills entire screen
            Color(red: 1.0, green: 0.74, blue: 0.55).opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header fixed at the top
                Text("Get In Shape")
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1.0, green: 0.9, blue: 0.8))
                    .shadow(radius: 3)
                
                Spacer(minLength: 25)
                                
                Text("Because You Can.").font(.title2).bold()
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 10)
                Text("Fitness and physical activity\nimpact IBD symptoms.").font(.headline)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 10)
                Text("Change Is Possible.").font(.subheadline)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 20)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 40) {
                        ForEach(videos) { video in
                            Button(action: {
                                // Open YouTube link
                                UIApplication.shared.open(video.youtubeURL)
                            }) {
                                VStack {
                                    Spacer()
                                    ZStack {
                                        Image(video.thumbnailName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 160, height: 160)
                                            .clipped()
                                            .cornerRadius(12)
                                            .shadow(radius: 5)
                                            
                                        Image(systemName: "play.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.gray)
                                            .opacity(0.7)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            // Remove default button appearance
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 10) // space above tab bar
    }
    
}

#Preview {
    BodyView()
}
