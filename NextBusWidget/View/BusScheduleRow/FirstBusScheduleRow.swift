//
//  FirstBusScheduleRow.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/16.
//

import SwiftUI

// 最初のバスを強調表示
struct FirstBusScheduleRow: View {
    var busSchedule: BusSchedule
    
    var body: some View {
        HStack {
            Text("1.") // 番号
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.gray.opacity(0.9))
            
            Text(busSchedule.arrivalTime)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.gray.opacity(0.9))
            
            Spacer()
        }
    }
}
