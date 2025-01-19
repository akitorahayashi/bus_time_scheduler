//
//  SmallNextBusWidgetView.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import SwiftUI

struct SmallNextBusWidgetView: View {
    var entry: NextBusEntry

    var body: some View {
        VStack(spacing: 8) {
            SelectedNextBusTimeSection(arrivalTime: entry.selectedBusSchedule?.arrivalTime)
            
            Divider()
            
            CountdownSection(arrivalTime: entry.selectedBusSchedule?.arrivalTime, referenceDate: entry.date)
        }
        .padding()
    }
}
