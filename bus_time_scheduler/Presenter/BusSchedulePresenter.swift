//
//  BusSchedulePresenter.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import Foundation

final class BusSchedulePresenter {
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
    
    var currentSelectedIndex: Int? {
        busSchedules.firstIndex {
            $0.isSelected
        }
    }
    
    func nearestScheduleIndex(currentTime: String) -> Int? {
        // 現在時刻以降の最初のバスを検索
        if let nearestSchedule = busSchedules.firstIndex(where: { $0.arrivalTime >= currentTime }) {
            return nearestSchedule
        } else {
            // 見つからなかった場合、一番早いバス（最初のスケジュール）を返す
            return 0
        }
    }
    
    // MARK: - UserDefaults
    private func saveBusSchedules() {
        let userDefaults = UserDefaults(suiteName: UserDefaultsKeys.suitName.rawValue)
        if let userDefaults = userDefaults {
            let encodedSchedules = try? JSONEncoder().encode(busSchedules)
            userDefaults.set(encodedSchedules, forKey: UserDefaultsKeys.busSchedulesKey.rawValue)
        }
    }
    
    private func saveSelectedIndex() {
        let userDefaults = UserDefaults(suiteName: UserDefaultsKeys.suitName.rawValue)
        if let userDefaults = userDefaults {
            userDefaults.set(selectedBusScheduleIndex, forKey: UserDefaultsKeys.selectedIndexKey.rawValue)
        }
    }
    
    private func loadData() {
//                let userDefaults = UserDefaults(suiteName: UserDefaultsManager.suitName)
//                if let userDefaults = userDefaults,
//                   let savedSchedulesData = userDefaults.data(forKey: UserDefaultsManager.busSchedulesKey),
//                   let savedSchedules = try? JSONDecoder().decode([BusSchedule].self, from: savedSchedulesData) {
//                    busSchedules = savedSchedules
//                } else {
        busSchedules = Constant.busSchedules
//                }
        
        selectedBusScheduleIndex = nil
//                userDefaults?.integer(forKey: UserDefaultsManager.selectedIndexKey)
    }
}
