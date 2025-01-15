//
//  BusSchedulePresenter.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

class BusSchedulePresenter {
    private(set) var busSchedules: [BusSchedule]
    private(set) var selectedIndex: Int?
    
    // MARK: - Initializer
    init(busSchedules: [BusSchedule]) {
        self.busSchedules = busSchedules
        self.selectedIndex = nil
    }
    
    func numberOfSchedules() -> Int {
        return busSchedules.count
    }
    
    func schedule(at index: Int) -> BusSchedule? {
        guard index >= 0 && index < busSchedules.count else { return nil }
        return busSchedules[index]
    }
    
    func toggleSelection(at index: Int) {
        if selectedIndex == index {
            busSchedules[index].isSelected = false
            selectedIndex = nil
        } else {
            if let previousIndex = selectedIndex {
                busSchedules[previousIndex].isSelected = false
            }
            busSchedules[index].isSelected = true
            selectedIndex = index
        }
    }
    
    // Find the nearest schedule
    func nearestScheduleIndex(currentTime: String) -> Int? {
        return busSchedules.firstIndex(where: { $0.arrivalTime >= currentTime })
    }
}
