//
//  LogManager.swift
//  IBDbuddy
//
//  Created by Adina on 6/30/25.
//

import Foundation

class LogManager: ObservableObject {
    /// Array tracks logged data from past week -  expand later
    @Published private(set) var logs: [DailyLog] = []

    /// Key enables saving/reading info to/from UserDefaults
    private let logsKey = "allLogs" // accesses all weekly logs
    
    init() {
        loadLogs() // load the saved array
        // called when LogManager is instantiated
    }
    
    // - - - Variables - - -
    
    /// Has the user already logged today?
    var didLogToday: Bool {
        guard let last = logs.last else { return false }
        return Calendar.current.isDateInToday(last.date)
    }

    /// Days since last log (nil if they logged today or never)
    var daysSinceLastLog: Int? {
        guard let last = logs.last else { return nil }
        let cal = Calendar.current
        let diff = cal.dateComponents([.day], from: cal.startOfDay(for: last.date), to: cal.startOfDay(for: Date())).day ?? 0
        return diff == 0 ? nil : diff
        }
    
    /// Subset of logs from past 7 days (including today)
//    var last7Days: [DailyLog] {
//        let cal = Calendar.current
//        let weekAgo = cal.startOfDay(for: Date()).addingTimeInterval(-6 * 24*60*60)
//        return logs.filter { cal.startOfDay(for: $0.date) >= weekAgo }
//    }
    var last7Days: [DailyLog] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return (0..<7).compactMap { offset in
            let day = calendar.date(byAdding: .day, value: -offset, to: today)!
            let match = logs.first { calendar.isDate($0.date, inSameDayAs: day) }
            return match ?? DailyLog(date: day, sleepHours: 0, exerciseMins: 0, calories: 0)
        }.reversed()
    }

    
    // - - - Functions - - -
    
    /// Add a new log entry and persist the full array.
    func addLog(_ log: DailyLog) {
        logs.append(log)
        saveLogs()
    }

    /// Removes only today’s entry (if any), leaving prior logs intact.
    func resetTodayStatus() {
        let calendar = Calendar.current
        // Keep only logs whose date is not today
        logs = logs.filter { !calendar.isDateInToday($0.date) }
        saveLogs()
    }
    
    /// Loads the full log array from UserDefaults.
    private func loadLogs() {
        if let data = UserDefaults.standard.data(forKey: logsKey),
            let decoded = try? JSONDecoder().decode([DailyLog].self, from: data) {
                logs = decoded
        } else {
            logs = []
        }
    }
    
    /// Saves the full log array to UserDefaults.
    private func saveLogs() {
        if let encoded = try? JSONEncoder().encode(logs) {
            UserDefaults.standard.set(encoded, forKey: logsKey)
        }
    }
    
    /// Fills log array for testing
    func generateMockWeek() {
        let calendar = Calendar.current
        logs = (0..<7).map { offset in /// Creates 7-day range, maps each number as a DailyLog
            let date = calendar.date(byAdding: .day, value: -offset, to: Date())!
            /// subtracts offsets days from today
            return DailyLog(
                /// sets random values for some days, some set to 0
                date: date,
                sleepHours: offset == 1 ? 0 : Double.random(in: 5...9),
                exerciseMins: offset == 2 ? 0 : Int.random(in: 0...60),
                calories: offset == 3 ? 0 : Int.random(in: 1500...2500)
            )
        }.reversed() /// places oldest day first, latest day last
            
        saveLogs() /// saves to UserDefaults - not needed for testing
    }

}
