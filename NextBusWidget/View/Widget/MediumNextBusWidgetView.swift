//
//  MediumNextBusWidgetView.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import SwiftUI

struct MediumNextBusWidgetView: View {
    var entry: NextBusEntry

    var body: some View {
        VStack(spacing: 8) {
            Text("Rendered at: \(entry.date.formatted())")
                .font(.caption)
                .foregroundColor(.gray)
            
            SelectedNextBusTimeSection(arrivalTime: entry.selectedBusSchedule?.arrivalTime)
            
            Divider()
            
            CountdownSection(arrivalTime: entry.selectedBusSchedule?.arrivalTime, referenceDate: entry.date)
        }
        .padding()
    }
}
