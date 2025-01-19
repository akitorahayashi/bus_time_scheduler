//
//  CountdownSection.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import SwiftUI

struct CountdownSection: View {
    let arrivalTime: String?
    let referenceDate: Date

    var body: some View {
        VStack {
            Text("COUNTDOWN")
                .fontWeight(.bold)
                .font(.system(size: 12))
                .foregroundColor(.accent)
            Group {
                if let arrivalTime = arrivalTime, let countdown = calculateTimeUntil(arrivalTime, from: referenceDate) {
                    // 時間が選択されている場合または最も早い時間がある場合
                    Text(countdown)
                } else {
                    Text("N/A")
                }
            }
            .font(.system(size: 18))
            .fontWeight(.bold)
            .foregroundColor(.gray.opacity(0.9))
        }
    }

    /// カウントダウンの時間を計算
    private func calculateTimeUntil(_ arrivalTime: String, from referenceDate: Date) -> String? {
        let calendar = Calendar.current
        
        // 到着時間をパース
        let components = arrivalTime.split(separator: ":").compactMap { Int($0) }
        guard components.count == 2, let hour = components.first, let minute = components.last else {
            return nil
        }
        
        // 基準日時から到着時間を生成
        var targetDate = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: referenceDate)
        
        // 到着時間が基準日時よりも前の場合、1日加算して翌日の時間に設定
        if let targetDateUnwrapped = targetDate, targetDateUnwrapped < referenceDate {
            targetDate = calendar.date(byAdding: .day, value: 1, to: targetDateUnwrapped)
        }
        
        guard let validTargetDate = targetDate else {
            return nil
        }
        
        // 基準日時からターゲット時刻までの時間差を計算
        var remainingTime = calendar.dateComponents([.hour, .minute, .second], from: referenceDate, to: validTargetDate)
        
        // 秒を基に切り上げ処理を行う
        if let seconds = remainingTime.second, seconds > 0 {
            remainingTime.minute = (remainingTime.minute ?? 0) + 1
        }
        
        let hours = remainingTime.hour ?? 0
        let minutes = remainingTime.minute ?? 0
        
        return String(format: "%02d:%02d", hours, minutes)
    }

}
