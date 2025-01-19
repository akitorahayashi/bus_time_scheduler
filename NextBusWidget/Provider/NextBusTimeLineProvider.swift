//
//  NextBusTimeLineProvider.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import Foundation
import WidgetKit
import SwiftUI

struct NextBusTimeLineProvider: TimelineProvider {
    func placeholder(in context: Context) -> NextBusEntry {
        NextBusEntry(date: Date(), corrBusSchedules: [], selectedBusScheduleIndex: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (NextBusEntry) -> Void) {
        let schedules = fetchBusSchedules()
        let selectedIndex = fetchSelectedBusIndex()
        let entry = NextBusEntry(date: Date().startOfMinute(), corrBusSchedules: schedules, selectedBusScheduleIndex: selectedIndex)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<NextBusEntry>) -> Void) {
        var entries: [NextBusEntry] = []
        let currentDate = Date().startOfMinute()
        
        let schedules = fetchBusSchedules()
        let selectedIndex = fetchSelectedBusIndex()

        if schedules.isEmpty {
            // スケジュールが存在しない場合の処理
            let entry = NextBusEntry(date: currentDate, corrBusSchedules: schedules, selectedBusScheduleIndex: nil)
            entries.append(entry)
            let timeline = Timeline(entries: entries, policy: .never)
            completion(timeline)
            return
        }

        // 60分間、1分ごとにエントリーを作成
        for minuteOffset in 0..<60 {
            let entryDate = currentDate.addingTimeInterval(TimeInterval(minuteOffset * 60))
            let entry = NextBusEntry(
                date: entryDate,
                corrBusSchedules: schedules,
                selectedBusScheduleIndex: selectedIndex
            )
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    /// AppGroups からバススケジュールリストを取得
    private func fetchBusSchedules() -> [BusSchedule] {
        let userDefaults = UserDefaults(suiteName: UserDefaultsKeys.suitName.rawValue)
        guard let data = userDefaults?.data(forKey: UserDefaultsKeys.busSchedulesKey.rawValue),
              let busSchedules = try? JSONDecoder().decode([BusSchedule].self, from: data) else {
            return []
        }
        return busSchedules
    }

    /// AppGroups から選択されたバススケジュールのインデックスを取得
    private func fetchSelectedBusIndex() -> Int? {
        let userDefaults = UserDefaults(suiteName: UserDefaultsKeys.suitName.rawValue)
        guard let selectedIndex = userDefaults?.object(forKey: UserDefaultsKeys.selectedIndexKey.rawValue) as? Int else {
            return nil
        }
        return selectedIndex
    }
}

/// `Date` の分の開始時刻を取得するための拡張
private extension Date {
    func startOfMinute() -> Date {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self))!
    }
}
