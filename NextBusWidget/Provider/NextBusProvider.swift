//
//  NextBusProvider.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import WidgetKit
import SwiftUI

struct NextBusProvider: TimelineProvider {
    func placeholder(in context: Context) -> NextBusEntry {
        return NextBusEntry(date: Date(), busSchedules: kBusSchedules, selectedBusScheduleIndex: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (NextBusEntry) -> ()) {
        let entry = NextBusEntry(date: Date(), busSchedules: getNextBusSchedules(), selectedBusScheduleIndex: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<NextBusEntry>) -> ()) {
        var entries: [NextBusEntry] = []
        
        // 15分ごとに更新
        let currentDate = Date()
        let nextBusSchedules = getNextBusSchedules()

        let entry = NextBusEntry(date: currentDate, busSchedules: nextBusSchedules, selectedBusScheduleIndex: nil)
        entries.append(entry)
        
        // 15分後のエントリを追加
        let nextUpdateDate = Calendar.current.date(byAdding: .second, value: 1, to: currentDate)!
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        
        completion(timeline)
    }

    // 現在時刻から近いバスの7本を取得する関数
    func getNextBusSchedules() -> [BusSchedule] {
        let currentDate = Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        // 時刻をDate型に変換
        let currentTimeString = formatter.string(from: currentDate)

        // 現在時刻以降のバスのスケジュールをフィルタリング
        let upcomingSchedules = kBusSchedules.filter { busSchedule in
            return busSchedule.arrivalTime >= currentTimeString
        }

        // 最初の8本を返す
        return Array(upcomingSchedules.prefix(8))
    }
}
