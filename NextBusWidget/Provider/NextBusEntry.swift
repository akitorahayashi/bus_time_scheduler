//
//  NextBusEntry.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import WidgetKit

struct NextBusEntry: TimelineEntry {
    let date: Date
    let busSchedules: [BusSchedule]
    let selectedBusScheduleIndex: Int?
}
