//
//  MindView.swift
//  IBDbuddy
//
//  Created by Adina on 7/3/25.
//
import SwiftUI

struct MindVideo: Identifiable {
    let id = UUID()
    let title: String
    let thumbnailName: String // matches an image in Assets
    let youtubeURL: URL
}

struct MindView: View {
    // Video data
    let videos = [
        MindVideo(title: "Calm Body & Mind", thumbnailName: "CalmBody&Mind", youtubeURL: URL(string: "https://www.youtube.com/watch?v=a2pZOIzbp7Q")!),
        MindVideo(title: "Overcoming Anxiety", thumbnailName: "OvercomingAnxiety", youtubeURL: URL(string: "https://www.youtube.com/watch?v=HT_ZvD94_kE")!),
        MindVideo(title: "Envisioning Healing", thumbnailName: "EnvisioningHealing", youtubeURL: URL(string: "https://www.youtube.com/watch?v=35Y8JUNb2v4")!),
        MindVideo(title: "Face Your Fears", thumbnailName: "FaceYourFears", youtubeURL: URL(string: "https://www.youtube.com/watch?v=HT_ZvD94_kE")!),
        MindVideo(title: "Compassion", thumbnailName: "Compassion", youtubeURL: URL(string: "https://www.youtube.com/watch?v=-d_AA9H4z9U")!),
        MindVideo(title: "Clear Your Mind", thumbnailName: "ClearYourMind", youtubeURL: URL(string: "https://www.youtube.com/watch?v=uTN29kj7e-w")!),
        MindVideo(title: "Deep Sleep", thumbnailName: "DeepSleep", youtubeURL: URL(string: "https://www.youtube.com/watch?v=s9WPtnC_vGQ")!),
        MindVideo(title: "Pain & Discomfort", thumbnailName: "Pain&Discomfort", youtubeURL: URL(string: "https://www.youtube.com/watch?v=L3-SlMJHrms")!),
        MindVideo(title: "Accepting Anger", thumbnailName: "AcceptingAnger", youtubeURL: URL(string: "https://www.youtube.com/watch?v=z4nPkS5Gz5Y")!),
        MindVideo(title: "Reframing", thumbnailName: "Reframing", youtubeURL: URL(string: "https://www.youtube.com/watch?v=Ae82GzZs44k")!),
        MindVideo(title: "Morning Calm", thumbnailName: "MorningCalm", youtubeURL: URL(string: "https://www.youtube.com/watch?v=nSBGjaDpdY8")!),
        MindVideo(title: "Presence", thumbnailName: "Presence", youtubeURL: URL(string: "https://www.youtube.com/watch?v=Bp89OCfXcWI")!)
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
                Text("Set Your Mind Right")
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1.0, green: 0.9, blue: 0.8))
                    .shadow(radius: 3)
                
                Spacer(minLength: 25)
                                
                Text("Because Mindfulness Matters.").font(.title2).bold()
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 5)
                Text("Home for all your mental health needs.").font(.headline)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 5)
                Text("Meditation, mindfulness, motivation, and more.").font(.subheadline)
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
                                            .opacity(0.65)
                                            
                                        Image(systemName: "play.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.white)
                                            .opacity(0.85)
                                    }
                                        
                                    Text(video.title)
                                        .font(.subheadline)
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.primary)
                                        .padding(.top, 5)
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
    MindView()
}

