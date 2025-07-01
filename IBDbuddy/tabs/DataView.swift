//
//  DataView.swift
//  IBDbuddy
//
//  Created by Adina Gross on 6/24/25.
//
import SwiftUI
import Charts

struct DataView: View {
    @EnvironmentObject var logManager: LogManager
    
    private var todayLog: DailyLog? {
        logManager.logs.last { Calendar.current.isDateInToday($0.date) }
    }
    
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
                    Text("Your Weekly Stats")
                        .font(.headline)
                        .padding()
                    
                    //                    Image(systemName: "clipboard")
                    //                        .resizable()
                    //                        .scaledToFit()
                    //                        .frame(width: 150, height: 300)
                    
                    if let log = todayLog {
                        Chart {
                            BarMark(
                                x: .value("Metric", "Sleep"),
                                y: .value("Hours", log.sleepHours)
                            )
                            BarMark(
                                x: .value("Metric", "Exercise"),
                                y: .value("Minutes", log.exerciseMins)
                            )
                            BarMark(
                                x: .value("Metric", "Calories"),
                                y: .value("Calories", log.calories)
                            )
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .frame(height: 200)
                    } else {
                        Text("No log recorded for today yet.")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
            Spacer()
        }
    }
}

#Preview {
    DataView()
        .environmentObject(LogManager())
}
