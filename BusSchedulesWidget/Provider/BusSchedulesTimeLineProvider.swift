//
//  BusSchedulesTimeLineProvider.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/18.
//

import WidgetKit
import SwiftUI

struct BusSchedulesTimeLineProvider: TimelineProvider {
    func placeholder(in context: Context) -> BusSchedulesEntry {
        return BusSchedulesEntry(date: Date(), busSchedules: BusSchedulesConstants.busSchedules)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (BusSchedulesEntry) -> ()) {
        let entry = BusSchedulesEntry(date: Date(), busSchedules: getNextBusSchedules(currentDate: BSDateUtilities.currentDate(), busSchedules: BusSchedulesConstants.busSchedules))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<BusSchedulesEntry>) -> ()) {
        var entries: [BusSchedulesEntry] = []
        let currentDate = BSDateUtilities.currentDate()
        let calendar = Calendar.current

        // 現在時刻以降のスケジュールを取得
        let nextBusSchedules = getNextBusSchedules(currentDate: currentDate, busSchedules: BusSchedulesConstants.busSchedules)

        for schedule in nextBusSchedules {
            // スケジュールの時刻を生成
            guard let scheduleDate = calendar.date(bySettingHour: schedule.arrivalTime.hour,
                                                   // その時間の次の分になったら更新
                                                   minute: schedule.arrivalTime.minute + 1,
                                                   second: 0,
                                                   of: currentDate) else {
                continue
            }

            // スケジュールが現在時刻より過去の場合は翌日のスケジュールとして設定
            let validScheduleDate = scheduleDate >= currentDate
                ? scheduleDate
                : calendar.date(byAdding: .day, value: 1, to: scheduleDate)!

            // タイムラインエントリーを作成
            let entry = BusSchedulesEntry(
                date: validScheduleDate,
                busSchedules: nextBusSchedules
            )
            entries.append(entry)
        }

        // タイムラインを生成
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    
    // 現在時刻から近いバスの7本を取得する関数
    func getNextBusSchedules(
        currentDate: Date,
        busSchedules: [BusSchedule]
    ) -> [BusSchedule] {
        // 現在時刻を BSFixedTime に変換
        let currentFixedTime = BSFixedTime(from: currentDate)
        
        // 現在時刻以降のバスのスケジュールをフィルタリング
        let upcomingSchedules = busSchedules.filter { busSchedule in
            busSchedule.arrivalTime >= currentFixedTime
        }
        
        // スケジュールが空の場合、先頭から8つを取得して返す
        if upcomingSchedules.isEmpty {
            return Array(busSchedules.prefix(8))
        }
        
        // 最初の8本を返す（次の日の分）
        return Array(upcomingSchedules.prefix(8))
    }

}
