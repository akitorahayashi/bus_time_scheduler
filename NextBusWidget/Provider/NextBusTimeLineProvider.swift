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
        NextBusEntry(date: Date(), selectedBusSchedule: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (NextBusEntry) -> Void) {
        let selectedBus = fetchSelectedBusSchedule()
        let entry = NextBusEntry(date: Date(), selectedBusSchedule: selectedBus)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<NextBusEntry>) -> Void) {
        var entries: [NextBusEntry] = []
        let currentDate = Date()
        
        // 現在のバススケジュールを取得
        guard let selectedBus = fetchSelectedBusSchedule() else {
            // selectedBusSchedule が nil の場合は更新しない
            let timeline = Timeline<NextBusEntry>(entries: [], policy: .never)
            completion(timeline)
            return
        }
        
        // 60分間、1分ごとにエントリーを作成
        var previousEntry: NextBusEntry?
        for minuteOffset in 0..<60 {
            let renderDate: Date
            if let previousEntry = previousEntry {
                renderDate = previousEntry.date.addingTimeInterval(60)
            } else {
                renderDate = currentDate.startOfMinute()
            }
            
            let entry = NextBusEntry(
                date: renderDate,
                selectedBusSchedule: selectedBus
            )
            entries.append(entry)
            previousEntry = entry
        }
        
        // タイムラインを作成
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    /// AppGroupsから選択されたバススケジュールを取得
    private func fetchSelectedBusSchedule() -> BusSchedule? {
        let userDefaults = UserDefaults(suiteName: UserDefaultsKeys.suitName.rawValue)
        guard let data = userDefaults?.data(forKey: UserDefaultsKeys.busSchedulesKey.rawValue),
              let busSchedules = try? JSONDecoder().decode([BusSchedule].self, from: data),
              let selectedIndex = userDefaults?.integer(forKey: UserDefaultsKeys.selectedIndexKey.rawValue),
              busSchedules.indices.contains(selectedIndex) else {
            return nil
        }
        return busSchedules[selectedIndex]
    }
}

/// `Date`の分の開始時刻を取得するための拡張
private extension Date {
    func startOfMinute() -> Date {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self))!
    }
}
