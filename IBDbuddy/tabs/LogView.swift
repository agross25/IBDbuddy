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
    @State private var isHovering = false /// enables button to change when mouse hovers
    @EnvironmentObject var logManager: LogManager
    
    // @AppStorage("latestLog") private var latestLogData: Data = Data()
    
    var body: some View {
        VStack {
            Spacer(minLength: 30)
            
            /// Header Rectangle with Date
            ZStack {
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

            /// Main Daily Log Box
            ZStack {
                /// Rounded background container
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(red: 1.0, green: 0.74, blue: 0.55).opacity(0.4))
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(radius: 5)
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                    .frame(maxHeight: 550)
                
                VStack(spacing: 20) {
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
                        }
                    
                    Button("Save Log") {
                        let newLog = DailyLog(
                            date: Date(),
                            sleepHours: sleepHours,
                            exerciseMins: exerciseMins,
                            calories: calories
                        )
                        logManager.addLog(newLog) /// saves today's date
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(isHovering ? .orange.opacity(0.8) : .orange)
                    .onHover { hovering in isHovering = hovering }
                    .disabled(logManager.didLogToday) // disable if already logged
                    .padding(.top)
                    
                    /// Display message to user
                    if logManager.didLogToday {
                        Text("Thank you for logging today! 😊")
                            .foregroundColor(.green)
                    }
                    else if let days = logManager.daysSinceLastLog {
                        Text("It has been \(days) day\(days == 1 ? "" : "s") since your last log.")
                            .foregroundColor(.orange)
                    }
                    
                    Button("🔄 Reset Log Status") {
                        logManager.resetTodayStatus()
                    }
                    .font(.caption)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 40)
                .padding(.vertical)
            }
            
            Spacer()
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

