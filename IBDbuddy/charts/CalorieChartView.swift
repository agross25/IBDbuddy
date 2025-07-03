//
//  CalorieChartView.swift
//  IBDbuddy
//
//  Created by Adina on 7/3/25.
//
import SwiftUI
import Charts

struct CalorieChartView: View {
    let weekLogs: [DailyLog]
    let formatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Calories Consumed:").font(.headline)
            Chart {
                ForEach(weekLogs) { log in
                    LineMark(
                        x: .value("Day", log.date, unit: .day),
                        y: .value("Calories", log.calories)
                    )
                    .foregroundStyle(Color(red: 1.0, green: 0.75, blue: 0.55))
                    .interpolationMethod(.catmullRom)
                    
                    PointMark(
                        x: .value("Day", log.date, unit: .day),
                        y: .value("Calories", log.calories)
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
                            return Text(formatter.string(from: date))
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
        .padding(.vertical, 10)
        .border(.gray, width: 3)
    }
}

