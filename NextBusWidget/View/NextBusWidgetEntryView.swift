//
//  NextBusWidgetEntryView.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import SwiftUI

struct NextBusWidgetEntryView: View {
    var entry: NextBusEntry

    var body: some View {
        VStack(spacing: 8) {
            // デバッグ用: エントリー時刻を表示
            Text("Rendered at: \(entry.date.formatted())")
                .font(.caption)
                .foregroundColor(.gray)

            // 上部セクション: 選択した時間の表示
            VStack {
                Text("Next Bus:")
                if let selectedBus = entry.selectedBusSchedule {
                    Text(selectedBus.arrivalTime.formatted())
                } else {
                    Text("No schedule selected")
                }
            }

            Divider() // セクションを分ける線

            // 下部セクション: 選択した時間までのカウントダウン表示
            VStack {
                Text("Countdown:")
                if let selectedBus = entry.selectedBusSchedule {
                    let countdown = calculateTimeUntil(selectedBus.arrivalTime, from: entry.date)
                    Text(countdown)
                } else {
                    Text("N/A")
                }
            }
        }
        .padding()
    }

    /// 指定した時刻から到着時刻までの残り時間を計算 (hh:mm形式)
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
