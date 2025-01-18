//
//  BusSchedulesWidgetEntryView.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/18.
//

import SwiftUI

struct BusSchedulesWidgetEntryView : View {
    var entry: BusSchedulesEntry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("NEXT")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.accent)
            
            // 最初のバス（最も近いバス）の表示
            if let firstBus = entry.busSchedules.first {
                FirstBusScheduleRow(busSchedule: firstBus)
            }
            
            Divider()
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.accent)
                )
            
            // 2番目以降のバスの表示
            let busSchedulesToShow = widgetFamily == .systemLarge ? entry.busSchedules.dropFirst().prefix(7) : entry.busSchedules.dropFirst().prefix(2)
            let totalRows = widgetFamily == .systemLarge ? 7 : 2

            VStack(alignment: .leading, spacing: 10) {
                // 足りない行数を空の行で埋める
                ForEach(busSchedulesToShow, id: \.arrivalTime) { busSchedule in
                    UpcomingBusScheduleRow(busSchedule: busSchedule, allSchedules: entry.busSchedules)
                }
                
                // 足りない行を空白で埋める
                ForEach(0..<totalRows - busSchedulesToShow.count, id: \.self) { _ in
                    UpcomingBusScheduleRow(busSchedule: BusSchedule(arrivalTime: ""), allSchedules: entry.busSchedules) // ダミーデータ
                        .opacity(0) // 見えなくする
                }
            }
        }
    }
}
