//
//  DailyLog.swift
//  IBDbuddy
//
//  Created by Adina Gross on 6/25/25.
//

import Foundation

struct DailyLog: Identifiable, Codable, Equatable {
    let id = UUID()
    let date: Date
    var sleepHours: Double
    var exerciseMins: Int
    var calories: Int
    
    /// Compute mood based on self-care score
    var mood: Mood {
        let score = (sleepHours >= 7 ? 1 : 0) + (exerciseMins >= 30 ? 1 : 0) + (calories <= 2000 ? 1 : 0)
        switch score {
        case 3: return .happy
        case 2: return .fine
        default: return .sad
        }
    }
    
}
