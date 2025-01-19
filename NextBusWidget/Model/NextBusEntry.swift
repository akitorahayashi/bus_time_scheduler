//
//  NextBusEntry.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import WidgetKit

struct NextBusEntry: TimelineEntry {
    let date: Date
    let selectedBusSchedule: BusSchedule?
}
