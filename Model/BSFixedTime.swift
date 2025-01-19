//
//  BSFixedTime.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/18.
//

import Foundation

struct BSFixedTime: Codable, Hashable, Comparable {
    let hour: Int
    let minute: Int
    
    enum InitializationError: Error {
        case invalidHour(Int)
        case invalidMinute(Int)
    }
    
    init(hour: Int, minute: Int) throws {
        guard (0..<24).contains(hour) else {
            throw InitializationError.invalidHour(hour)
        }
        guard (0..<60).contains(minute) else {
            throw InitializationError.invalidMinute(minute)
        }
        self.hour = hour
        self.minute = minute
    }
    
    init(from date: Date) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        self.hour = components.hour ?? 0
        self.minute = components.minute ?? 0
    }
    
    func formatted() -> String {
        String(format: "%02d:%02d", hour, minute)
    }
    
    static func < (lhs: BSFixedTime, rhs: BSFixedTime) -> Bool {
        if lhs.hour != rhs.hour {
            return lhs.hour < rhs.hour
        }
        return lhs.minute < rhs.minute
    }
}
