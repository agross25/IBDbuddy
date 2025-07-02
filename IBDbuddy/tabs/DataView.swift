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
    // let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    private let weekdayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE" // "EEE" for short names
            return formatter
        }()
    
    var body: some View {
        let weekLogs = logManager.last7Days
        
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
                    Text("Weekly Stats")
                        .font(.headline)
                        .padding()
                    
                    // if let log = todayLog {
                    
                    // Sleep Chart
                    VStack(alignment: .leading) {
                        Text("Hours of Sleep:").font(.headline)
                        Chart {
                            ForEach(weekLogs) { log in
                                LineMark(
                                    x: .value("Day", log.date, unit: .day),
                                    y: .value("Hours", log.sleepHours)
                                )
                                .foregroundStyle(Color(red: 1.0, green: 0.75, blue: 0.55))
                                .interpolationMethod(.catmullRom) // smooths lines
                                
                                PointMark(
                                    x: .value("Day", log.date, unit: .day),
                                    y: .value("Hours", log.sleepHours)
                                )
                                .foregroundStyle(Color(red: 1.0, green: 0.75, blue: 0.55))
                                .symbolSize(50)
                            }
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .day)) { value in
                                AxisGridLine()
                                AxisTick()
                                AxisValueLabel {
                                    if let date = value.as(Date.self) {
                                        let isToday = Calendar.current.isDateInToday(date)
                                        return Text(weekdayFormatter.string(from: date))
                                            .fontWeight(isToday ? .bold : .regular)
                                    } else {
                                        return Text("")
                                    }
                                }
                            }
                        }
                        .frame(height: 120)
                    }
                    .padding(.horizontal, 40)
                    
                    // Exercise Chart
                    VStack(alignment: .leading) {
                        Text("Minutes of Exercise:").font(.headline)
                        Chart {
                            ForEach(weekLogs) { log in
                                LineMark(
                                    x: .value("Day", log.date, unit: .day),
                                    y: .value("Minutes", log.exerciseMins)
                                )
                                .foregroundStyle(Color(red: 1.0, green: 0.65, blue: 0.45))
                                .interpolationMethod(.catmullRom)
                                
                                PointMark(
                                    x: .value("Day", log.date, unit: .day),
                                    y: .value("Minutes", log.exerciseMins)
                                )
                                .foregroundStyle(Color(red: 1.0, green: 0.65, blue: 0.45))
                                .symbolSize(50)
                            }
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .day)) { value in
                                AxisGridLine()
                                AxisTick()
                                AxisValueLabel {
                                    if let date = value.as(Date.self) {
                                        let isToday = Calendar.current.isDateInToday(date)
                                        return Text(weekdayFormatter.string(from: date))
                                            .fontWeight(isToday ? .bold : .regular)
                                    } else {
                                        return Text("")
                                    }
                                }                            }
                        }
                        .frame(height: 120)
                    }
                    .padding(.horizontal, 40)
                    
                    // Calories Chart
                    VStack(alignment: .leading) {
                        Text("Calories Consumed:").font(.headline)
                        Chart {
                            ForEach(weekLogs) { log in
                                LineMark(
                                    x: .value("Day", log.date, unit: .day),
                                    y: .value("Calories", log.calories)
                                )
                                .foregroundStyle(Color(red: 0.95, green: 0.5, blue: 0.3))
                                .interpolationMethod(.catmullRom)
                                
                                PointMark(
                                    x: .value("Day", log.date, unit: .day),
                                    y: .value("Calories Consumed", log.calories)
                                )
                                .foregroundStyle(Color(red: 1.0, green: 0.5, blue: 0.3))
                                .symbolSize(50)
                            }
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        // Sets x-axis values to weekday names (or 'Today')
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .day)) { value in
                                AxisGridLine()
                                AxisTick()
                                AxisValueLabel {
                                    if let date = value.as(Date.self) {
                                        let isToday = Calendar.current.isDateInToday(date)
                                        return Text(weekdayFormatter.string(from: date))
                                            .fontWeight(isToday ? .bold : .regular)
                                    } else {
                                        return Text("")
                                    }
                                }
                            }
                        }
                        .frame(height: 120)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            if logManager.logs.isEmpty {
                logManager.generateMockWeek()
            }
        }
    }
}

#Preview {
    DataView()
        .environmentObject(LogManager())
}
