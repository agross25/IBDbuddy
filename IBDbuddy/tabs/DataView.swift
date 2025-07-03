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
    
    private let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // "EEE" for short names
        return formatter
    }()
    
    var body: some View {
        let weekLogs = logManager.last7Days
        
        ZStack {
            // Background color fills entire screen
            Color(red: 1.0, green: 0.74, blue: 0.55).opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header fixed at the top
                Text("Your Weekly Stats")
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1.0, green: 0.9, blue: 0.8))
                    .shadow(radius: 3)
                
                Spacer(minLength: 25)
                
                ScrollView {
                    VStack(spacing: 30) {
                        SleepChartView(weekLogs: weekLogs, formatter: weekdayFormatter)
                        ExerciseChartView(weekLogs: weekLogs, formatter: weekdayFormatter)
                        CalorieChartView(weekLogs: weekLogs, formatter: weekdayFormatter)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .onAppear {
            if logManager.logs.isEmpty {
                logManager.generateMockWeek()
            }
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    DataView()
        .environmentObject(LogManager())
}
