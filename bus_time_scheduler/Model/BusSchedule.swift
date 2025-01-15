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

let kBusSchedules: [BusSchedule] = [
    BusSchedule(arrivalTime: "08:14"),
    BusSchedule(arrivalTime: "08:26"),
    BusSchedule(arrivalTime: "08:42"),
    BusSchedule(arrivalTime: "08:54"),
    BusSchedule(arrivalTime: "09:10"),
    BusSchedule(arrivalTime: "09:22"),
    BusSchedule(arrivalTime: "09:38"),
    BusSchedule(arrivalTime: "09:50"),
    BusSchedule(arrivalTime: "10:06"),
    BusSchedule(arrivalTime: "10:18"),
    BusSchedule(arrivalTime: "10:34"),
    BusSchedule(arrivalTime: "10:46"),
    BusSchedule(arrivalTime: "11:02"),
    BusSchedule(arrivalTime: "11:14"),
    BusSchedule(arrivalTime: "11:30"),
    BusSchedule(arrivalTime: "11:42"),
    BusSchedule(arrivalTime: "11:58"),
    BusSchedule(arrivalTime: "12:10"),
    BusSchedule(arrivalTime: "12:26"),
    BusSchedule(arrivalTime: "12:38"),
    BusSchedule(arrivalTime: "12:54"),
    BusSchedule(arrivalTime: "13:06"),
    BusSchedule(arrivalTime: "13:22"),
    BusSchedule(arrivalTime: "13:34"),
    BusSchedule(arrivalTime: "13:50"),
    BusSchedule(arrivalTime: "14:02"),
    BusSchedule(arrivalTime: "14:18"),
    BusSchedule(arrivalTime: "14:30"),
    BusSchedule(arrivalTime: "14:46"),
    BusSchedule(arrivalTime: "14:58"),
    BusSchedule(arrivalTime: "15:14"),
    BusSchedule(arrivalTime: "15:26"),
    BusSchedule(arrivalTime: "15:42"),
    BusSchedule(arrivalTime: "15:54"),
    BusSchedule(arrivalTime: "16:10"),
    BusSchedule(arrivalTime: "16:22"),
    BusSchedule(arrivalTime: "16:38"),
    BusSchedule(arrivalTime: "16:50"),
    BusSchedule(arrivalTime: "17:06"),
    BusSchedule(arrivalTime: "17:18"),
    BusSchedule(arrivalTime: "17:34"),
    BusSchedule(arrivalTime: "17:46"),
    BusSchedule(arrivalTime: "18:02"),
    BusSchedule(arrivalTime: "18:14"),
    BusSchedule(arrivalTime: "18:30"),
    BusSchedule(arrivalTime: "18:42"),
    BusSchedule(arrivalTime: "18:58"),
    BusSchedule(arrivalTime: "19:10"),
    BusSchedule(arrivalTime: "19:26"),
    BusSchedule(arrivalTime: "19:38")
]
