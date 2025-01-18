//
//  UpcomingBusScheduleRow.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/18.
//

import SwiftUI

// 2番目以降のバスの行
struct UpcomingBusScheduleRow: View {
    var busSchedule: BusSchedule
    var allSchedules: [BusSchedule]
    
    var body: some View {
        let corrIdx: Int? = allSchedules.firstIndex(where: { $0.arrivalTime == busSchedule.arrivalTime })
        HStack {
            // 到着順を明示
            if let index = corrIdx {
                Text("\(index + 1).")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            
            // arrivalTimeを表示
            Text(busSchedule.arrivalTime)
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
        .padding(.leading, 8)
    }
}
