//
//  BusSchedulePresenter.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import Foundation

class BusSchedulePresenter {
    private(set) var busSchedules: [BusSchedule] {
        didSet {
            saveBusSchedules()
        }
    }
    
    private(set) var selectedBusScheduleIndex: Int? {
        didSet {
            saveSelectedIndex()
        }
    }

    init(busSchedules: [BusSchedule] = []) {
        self.busSchedules = busSchedules
        self.selectedBusScheduleIndex = nil
        loadData()
    }
    
    var numberOfSchedules: Int {
        return busSchedules.count
    }
    
    func busSchedule(at index: Int) -> BusSchedule? {
        guard index >= 0 && index < busSchedules.count else { return nil }
        return busSchedules[index]
    }
    
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
    
    func nearestScheduleIndex(currentTime: String) -> Int? {
        return busSchedules.firstIndex(where: { $0.arrivalTime >= currentTime })
    }
    
    // MARK: - UserDefaults
    private func saveBusSchedules() {
        let userDefaults = UserDefaults(suiteName: UserDefaultsManager.suitName)
        if let userDefaults = userDefaults {
            let encodedSchedules = try? JSONEncoder().encode(busSchedules)
            userDefaults.set(encodedSchedules, forKey: UserDefaultsManager.busSchedulesKey)
        }
    }
    
    private func saveSelectedIndex() {
        let userDefaults = UserDefaults(suiteName: UserDefaultsManager.suitName)
        if let userDefaults = userDefaults {
            userDefaults.set(selectedBusScheduleIndex, forKey: UserDefaultsManager.selectedIndexKey)
        }
    }
    
    private func loadData() {
        let userDefaults = UserDefaults(suiteName: UserDefaultsManager.suitName)
        if let userDefaults = userDefaults,
           let savedSchedulesData = userDefaults.data(forKey: UserDefaultsManager.busSchedulesKey),
           let savedSchedules = try? JSONDecoder().decode([BusSchedule].self, from: savedSchedulesData) {
            busSchedules = savedSchedules
        } else {
            busSchedules = kBusSchedules
        }
        
        selectedBusScheduleIndex = userDefaults?.integer(forKey: UserDefaultsManager.selectedIndexKey)
    }
}
