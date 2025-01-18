//
//  DateManager.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/16.
//

import Foundation

enum DateManager {
    // 現在の時刻か、デバッグ用の指定時刻（16:00）を返す
    static func currentDate() -> Date {
        if Constant.debugMode {
            return Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!
        } else {
            return Date()  // 現在時刻を返す
        }
    }
}

