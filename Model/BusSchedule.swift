//
//  BusSchedule.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

struct BusSchedule: Codable {
    var isSelected: Bool
    let arrivalTime: String
    let delayedTime: String?
    
    init(arrivalTime: String) {
        isSelected = false
        self.arrivalTime = arrivalTime
        self.delayedTime = nil
    }
}
