//
//  NextBusEntry.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import WidgetKit

struct NextBusEntry: TimelineEntry {
    let date: Date
    let corrBusSchedules: [BusSchedule]
    let selectedBusScheduleIndex: Int?
    
    /// 選択されたバススケジュールの到着時間を文字列形式で取得
        /// - Returns: `selectedBusScheduleIndex` に対応するバスの到着時間（`HH:mm`形式）。インデックスが無効な場合や選択されていない場合は `nil` を返す。
        var arrivalTimeString: String? {
            guard let index = selectedBusScheduleIndex,
                  corrBusSchedules.indices.contains(index) else {
                return nil
            }
            return corrBusSchedules[index].arrivalTime.formatted()
        }
    
    /// 現在時刻から最も早い到着時間を計算
        func nextAvailableTime(from referenceDate: Date) -> String? {
            // Date型の現在時刻を BSFixedTime に変換
            let currentFixedTime = BSFixedTime(from: referenceDate)
            
            // 現在時刻以降の最も早い到着時間を検索
            guard let nextBus = corrBusSchedules.first(where: { $0.arrivalTime >= currentFixedTime }) else {
                return nil
            }
            
            return nextBus.arrivalTime.formatted()
        }
}
