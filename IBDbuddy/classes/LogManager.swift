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
    
    /// Formats days by shortened weekday name
    let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
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
    
    var last7Days: [DailyLog] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return (0..<7).compactMap { offset -> DailyLog in
            guard let day = calendar.date(byAdding: .day, value: -offset, to: today) else {
                return DailyLog(
                    date: Date(),
                    sleepHours: 0,
                    exerciseMins: 0,
                    calories: 0,
                    tookMedication: false,
                    moodRating: 0,
                    mentalHealthMins: 0
                )
            }

            let match = logs.first { calendar.isDate($0.date, inSameDayAs: day) }
            return match ?? DailyLog(
                date: day,
                sleepHours: 0,
                exerciseMins: 0,
                calories: 0,
                tookMedication: false,
                moodRating: 0,
                mentalHealthMins: 0
            )
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
    
    func generateMockWeek() {
        let calendar = Calendar.current

        logs = (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: -offset, to: Date())!

            return DailyLog(
                date: date,
                sleepHours: Double.random(in: 4...9),
                exerciseMins: Int.random(in: 0...60),
                calories: Int.random(in: 1500...2500),
                tookMedication: Bool.random(),
                moodRating: Int.random(in: 2...9),
                mentalHealthMins: Int.random(in: 0...45)
            )
        }.reversed() // oldest first, latest last

        saveLogs() // persist to UserDefaults if needed
    }


}
