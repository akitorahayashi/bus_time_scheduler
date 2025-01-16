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
                        
        let nextBusSchedules = getNextBusSchedules()
        
        var previousEntry: NextBusEntry?
        
        for _ in nextBusSchedules {
            
            let renderDate: Date
            
            if let previousEntry {
                renderDate = previousEntry.date.addingTimeInterval(1)
            } else {
                renderDate = .init()
            }
            
            let entry = NextBusEntry(
                date: renderDate,
                busSchedules: nextBusSchedules,
                selectedBusScheduleIndex: nil
            )
            entries.append(entry)
            
            previousEntry = entry
        }
                      
        // タイムラインを作成
        let timeline = Timeline(entries: entries, policy: .atEnd)
        
        
        completion(timeline)
    }
    
    // 現在時刻から近いバスの7本を取得する関数
    func getNextBusSchedules() -> [BusSchedule] {
        let currentDate = DateManager.currentDate()
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
