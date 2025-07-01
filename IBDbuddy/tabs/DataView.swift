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
                    Text("Today's Stats")
                        .font(.headline)
                        .padding()
                    
                    if let log = todayLog {
                        // Sleep Chart
                        VStack(alignment: .leading) {
                            Text("Hours of Sleep:")
                                .font(.headline)
                            Chart {
                                BarMark(
                                    x: .value("Sleep", "Sleep"),
                                    y: .value("Hours", log.sleepHours)
                                )
                                .foregroundStyle(Color(red: 1.0, green: 0.7, blue: 0.5))
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .frame(height: 120)
                        }
                        .padding(.horizontal, 40)
                        
                        // Exercise Chart
                        VStack(alignment: .leading) {
                            Text("Minutes of Exercise:")
                                .font(.headline)
                            Chart {
                                BarMark(
                                    x: .value("Exercise", "Exercise"),
                                    y: .value("Minutes", log.exerciseMins)
                                )
                                .foregroundStyle(Color(red: 1.0, green: 0.65, blue: 0.45))
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .frame(height: 120)
                        }
                        .padding(.horizontal, 40)
                        
                        // Calories Chart
                        VStack(alignment: .leading) {
                            Text("Calories Consumed:")
                                .font(.headline)
                            Chart {
                                BarMark(
                                    x: .value("Calories", "Calories"),
                                    y: .value("Calories", log.calories)
                                )
                                .foregroundStyle(Color(red: 0.95, green: 0.65, blue: 0.4))
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .frame(height: 120)
                        }
                        .padding(.horizontal, 40)
                    } else {
                        Text("No log recorded for today yet.")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    DataView()
        .environmentObject(LogManager())
}
