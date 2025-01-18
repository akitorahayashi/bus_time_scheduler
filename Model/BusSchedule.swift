//
//  BusSchedule.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

struct BusSchedule {
    var isSelected: Bool
    // FIXME: use `Date
    let arrivalTime: BSFixedTime
    let delayedTime: BSFixedTime?
    
    init(arrivalTime: BSFixedTime, delayedTime: BSFixedTime? = nil) {
        isSelected = false
        self.arrivalTime = arrivalTime
        self.delayedTime = delayedTime
    }
}
