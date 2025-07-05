//
//  MedsChartView.swift
//  IBDbuddy
//
//  Created by Adina on 7/5/25.
//
import SwiftUI
import Charts

struct MedsChartView: View {
    let weekLogs: [DailyLog]
    let formatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Medication Taken:").font(.headline)
            Chart {
                ForEach(weekLogs) { log in
                    BarMark(
                        x: .value("Day", log.date, unit: .day),
                        y: .value("Took Meds", log.tookMedication ? 1 : 0)
                    )
                    .foregroundStyle(log.tookMedication ? .green : .red)
                    .annotation(position: .top) {
                        Text(log.tookMedication ? "Yes" : "No")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
            }
            .chartYAxis {
                AxisMarks(values: [0, 1]) { _ in
                    AxisGridLine()
                    AxisTick()
                }
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

