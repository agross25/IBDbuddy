//
//  LogView.swift
//  IBDbuddy
//
//  Created by Adina Gross on 6/24/25.
//

import SwiftUI

struct LogView: View {
    @State private var sleepHours: Double = 7
    @State private var exerciseMins: Int = 0
    @State private var calories: Int = 1500
    @State private var tookMedication: Bool = false
    @State private var moodRating: Int = 5
    @State private var mentalHealthMins: Int = 0

    @State private var isHovering = false /// button changes when mouse hovers
    @EnvironmentObject var logManager: LogManager
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        ZStack(alignment: .top) {
            // Background color fills entire screen
            Color(red: 1.0, green: 0.74, blue: 0.55).opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Spacer(minLength: 20)
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }

                    Text("Your Daily Log")
                        .font(.title)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .shadow(radius: 3)

                    Spacer(minLength: 40) // pushes everything left
                }
                .background(Color(red: 1.0, green: 0.9, blue: 0.8))
                .shadow(radius: 3)
                //.padding(.top,60)
                .ignoresSafeArea(.all)
                                
                Spacer()
                
                /// Header Rectangle with Date
                ZStack {
                    /// Today's date
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(red: 1.0, green: 0.7, blue: 0.36).opacity(0.5))
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(radius: 5)
                        .padding(.horizontal, 40)
                        .frame(height: 50)
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("Today is ") +
                        Text(Date().formatted(date: .long, time: .omitted)).bold()
                    }
                    .font(.subheadline)
                    
                }
                
                Spacer()
                
                /// Main Daily Log Box
                ZStack {
                    VStack(spacing: 30) {
                        Section(header: Text("How well did you take care of yourself today?")
                            .font(.title3)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding()) {
                                Stepper(value: $sleepHours, in: 0...12, step: 0.5) {
                                    Text("Sleep: \(sleepHours, specifier: "%.1f") hours")
                                }
                                Stepper(value: $exerciseMins, in: 0...180, step: 10) {
                                    Text("Exercise: \(exerciseMins) min")
                                }
                                Stepper(value: $calories, in: 0...4000, step: 100) {
                                    Text("Calories: \(calories) cals")
                                }
                                Toggle("Took Medication Today", isOn: $tookMedication)
                                Stepper(value: $moodRating, in: 1...10) {
                                    Text("Mood Rating: \(moodRating)/10")
                                }
                                Stepper(value: $mentalHealthMins, in: 0...120, step: 5) {
                                    Text("Mental Health Time: \(mentalHealthMins) mins")
                                }
                            }
                        
                        Button("Save Log") {
                            let newLog = DailyLog(
                                date: Date(),
                                sleepHours: sleepHours,
                                exerciseMins: exerciseMins,
                                calories: calories,
                                tookMedication: tookMedication,
                                moodRating: moodRating,
                                mentalHealthMins: mentalHealthMins
                            )
                            logManager.addLog(newLog) /// saves today's date
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(isHovering ? .orange.opacity(0.6) : .orange)
                        .onHover { hovering in isHovering = hovering }
                        .disabled(logManager.didLogToday) // disable if already logged
                        .padding(.top)
                        .bold()
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical)
                }
                Spacer()
            }
        }
        /// as soon as VStack appears, checks log status
        .onAppear {
            _ = logManager.didLogToday
        }
    }
}

#Preview {
    LogView()
        .environmentObject(LogManager())
}

