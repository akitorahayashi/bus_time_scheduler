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

    func getSnapshot(in context: Context, completion: @escaping (NextBusEntry) -> ()) {
        let selectedBus = loadSelectedBusSchedule()
        let entry = NextBusEntry(date: Date(), selectedBusSchedule: selectedBus)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<NextBusEntry>) -> ()) {
        let selectedBus = loadSelectedBusSchedule()
        let entry = NextBusEntry(date: Date(), selectedBusSchedule: selectedBus)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    private func loadSelectedBusSchedule() -> BusSchedule? {
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

