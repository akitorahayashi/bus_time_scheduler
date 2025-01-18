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
        let entry = BusSchedulesEntry(date: Date(), busSchedules: getNextBusSchedules(currentDate: DateManager.currentDate(), busSchedules: BusSchedulesConstants.busSchedules))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<BusSchedulesEntry>) -> ()) {
        
        var entries: [BusSchedulesEntry] = []
                        
        let nextBusSchedules = getNextBusSchedules(currentDate: DateManager.currentDate(), busSchedules: BusSchedulesConstants.busSchedules)
        
        var previousEntry: BusSchedulesEntry?
        
        for _ in nextBusSchedules {
            
            let renderDate: Date
            
            if let previousEntry {
                renderDate = previousEntry.date.addingTimeInterval(1)
            } else {
                renderDate = .init()
            }
            
            let entry = BusSchedulesEntry(
                date: renderDate,
                busSchedules: nextBusSchedules
            )
            entries.append(entry)
            previousEntry = entry
        }
                      
        // タイムラインを作成
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
