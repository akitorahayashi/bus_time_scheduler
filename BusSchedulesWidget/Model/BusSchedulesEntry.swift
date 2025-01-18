//
//  BusSchedulesEntry.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/18.
//

import WidgetKit

struct BusSchedulesEntry: TimelineEntry {
    let date: Date
    let busSchedules: [BusSchedule]
    let selectedBusScheduleIndex: Int?
    
    func followingSchedules() -> Array<BusSchedule>.SubSequence {
        
        let index = selectedBusScheduleIndex ?? 0
        
        let slice = busSchedules[index...]
        
        return slice
    }
}
