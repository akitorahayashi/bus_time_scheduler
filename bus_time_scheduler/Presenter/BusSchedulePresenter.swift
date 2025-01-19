//
//  BusSchedulePresenter.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import Foundation

final class BusSchedulePresenter {
    // MARK: - Properties
    private(set) var busSchedules: [BusSchedule]
    private(set) var selectedBusScheduleIndex: Int?
    
    // MARK: - Initializer
    init() {
        self.busSchedules = BusSchedulesConstants.busSchedules
        self.selectedBusScheduleIndex = nil
        loadSavedData()
    }
    
    // MARK: - Computed Properties (Value Retrieval)
    var numberOfSchedules: Int {
        return busSchedules.count
    }
    
    var currentSelectedIndex: Int? {
        busSchedules.firstIndex {
            $0.isSelected
        }
    }
    
    // MARK: - Value Retrieval
    func busSchedule(at index: Int) -> BusSchedule? {
        guard index >= 0 && index < busSchedules.count else { return nil }
        return busSchedules[index]
    }
    
    func nearestScheduleIndex(currentTime: Date) -> Int? {
        if let nearestSchedule = busSchedules.firstIndex(where: { $0.arrivalTime >= BSFixedTime(from: currentTime) }) {
            return nearestSchedule
        } else {
            return 0
        }
    }
    
    // MARK: - Value Manipulation
    func toggleSelection(at index: Int) {
        guard index >= 0 && index < busSchedules.count else { return }
        if selectedBusScheduleIndex == index {
            busSchedules[index].isSelected = false
            selectedBusScheduleIndex = nil
        } else {
            if let previousIndex = selectedBusScheduleIndex {
                busSchedules[previousIndex].isSelected = false
            }
            busSchedules[index].isSelected = true
            selectedBusScheduleIndex = index
        }
    }
    
    // MARK: - Data Loading
    func loadSavedData() {
        let userDefaults = UserDefaults(suiteName: UserDefaultsKeys.suitName.rawValue)
        
        if let savedData = userDefaults?.data(forKey: UserDefaultsKeys.busSchedulesKey.rawValue),
           let savedSchedules = try? JSONDecoder().decode([BusSchedule].self, from: savedData) {
            self.busSchedules = savedSchedules
        }
        
        if let savedIndex = userDefaults?.integer(forKey: UserDefaultsKeys.selectedIndexKey.rawValue),
           savedIndex >= 0 && savedIndex < busSchedules.count {
            self.selectedBusScheduleIndex = savedIndex
            busSchedules[savedIndex].isSelected = true
        } else {
            self.selectedBusScheduleIndex = nil
        }
    }
}
