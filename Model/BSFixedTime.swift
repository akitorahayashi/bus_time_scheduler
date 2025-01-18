//
//  BSFixedTime.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/18.
//

struct BSFixedTime {
    let hour: Int
    let minute: Int
    
    enum InitializationError: Error {
        case invalidHour(Int)
        case invalidMinute(Int)
        case invalidFormat(String)
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
    
    func formatted() -> String {
        String(format: "%02d:%02d", hour, minute)
    }
}
