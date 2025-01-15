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
        NextBusEntry(date: Date(), busSchedules: kBusSchedules, selectedBusScheduleIndex: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (NextBusEntry) -> ()) {
        let entry = NextBusEntry(date: Date(), busSchedules: kBusSchedules, selectedBusScheduleIndex: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<NextBusEntry>) -> ()) {
        var entries: [NextBusEntry] = []

        let schedules = kBusSchedules
        let selectedIndex: Int? = 1
        
        let entry = NextBusEntry(date: Date(), busSchedules: schedules, selectedBusScheduleIndex: selectedIndex)
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
