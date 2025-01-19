//
//  CountdownSection.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import SwiftUI

struct CountdownSection: View {
    let arrivalTime: BSFixedTime?
    let referenceDate: Date

    var body: some View {
        VStack {
            Text("Countdown:")
            if let arrivalTime = arrivalTime {
                let countdown = calculateTimeUntil(arrivalTime, from: referenceDate)
                Text(countdown)
            } else {
                Text("N/A")
            }
        }
    }

    /// 残り時間を計算
    private func calculateTimeUntil(_ arrivalTime: BSFixedTime, from referenceDate: Date) -> String {
        let calendar = Calendar.current
        
        // 基準日時から到着時間を生成
        guard let targetDate = arrivalTime.toDate(from: referenceDate) else {
            return "Invalid Time"
        }
        
        // 基準日時からターゲット時刻までの時間差を計算
        var remainingTime = calendar.dateComponents([.hour, .minute, .second], from: referenceDate, to: targetDate)
        
        // 秒を基に切り上げ処理を行う
        if let seconds = remainingTime.second, seconds > 0 {
            remainingTime.minute = (remainingTime.minute ?? 0) + 1
        }
        
        let hours = remainingTime.hour ?? 0
        let minutes = remainingTime.minute ?? 0
        
        return String(format: "%02d:%02d", hours, minutes)
    }
}

private extension BSFixedTime {
    /// 基準日を基にBSFixedTimeをDateに変換
    func toDate(from referenceDate: Date) -> Date? {
        let calendar = Calendar.current
        
        // 今日の到着時間
        if let todayArrivalDate = calendar.date(bySettingHour: self.hour,
                                                minute: self.minute,
                                                second: 0,
                                                of: referenceDate),
           todayArrivalDate >= referenceDate {
            return todayArrivalDate
        }
        
        // 今日の時間を過ぎている場合は翌日の時間とみなす
        return calendar.date(byAdding: .day, value: 1, to: calendar.date(bySettingHour: self.hour,
                                                                         minute: self.minute,
                                                                         second: 0,
                                                                         of: referenceDate)!)
    }
}
