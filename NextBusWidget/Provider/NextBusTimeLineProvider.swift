//
//  NextBusTimeLineProvider.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import WidgetKit
import SwiftUI

struct NextBusTimeLineProvider: TimelineProvider {
    func placeholder(in context: Context) -> NextBusEntry {
        NextBusEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (NextBusEntry) -> ()) {
        let entry = NextBusEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<NextBusEntry>) -> ()) {
        var entries: [NextBusEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = NextBusEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline<NextBusEntry>(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
