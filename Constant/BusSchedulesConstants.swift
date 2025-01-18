//
//  BusSchedulesConstants.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/18.
//

import Foundation

enum BusSchedulesConstants {
    static let selectedBusScheduleIndex: Int = 0

    static let busSchedules: [BusSchedule] = {
        let timeTuples: [(hour: Int, minute: Int)] = [
            (8, 14), (8, 26), (8, 42), (8, 54),
            (9, 10), (9, 22), (9, 38), (9, 50),
            (10, 6), (10, 18), (10, 34), (10, 46),
            (11, 2), (11, 14), (11, 30), (11, 42), (11, 58),
            (12, 10), (12, 26), (12, 38), (12, 54),
            (13, 6), (13, 22), (13, 34), (13, 50),
            (14, 2), (14, 18), (14, 30), (14, 46), (14, 58),
            (15, 14), (15, 26), (15, 42), (15, 54),
            (16, 10), (16, 22), (16, 38), (16, 50),
            (17, 6), (17, 18), (17, 34), (17, 46),
            (18, 2), (18, 14), (18, 30), (18, 42), (18, 58),
            (19, 10), (19, 26), (19, 38)
        ]
        
        return timeTuples.map { time in
            do {
                let fixedTime = try BSFixedTime(hour: time.hour, minute: time.minute)
                return BusSchedule(arrivalTime: fixedTime)
            } catch {
                assertionFailure("Invalid time data: \(time.hour):\(time.minute) - \(error)")
                // デフォルト値（到達しない想定）
                return BusSchedule(arrivalTime: try! BSFixedTime(hour: 0, minute: 0))
            }
        }
    }()
}
