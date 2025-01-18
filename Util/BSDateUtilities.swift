//
//  BSDateUtilities.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/18.
//

import Foundation

enum BSDateUtilities {
    static func currentDate() -> Date {
        if BSAppSettings.debugMode {
            return Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!
        }
        return Date()
    }
}
