//
//  NextBusWidgetEntryView.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import SwiftUI

struct NextBusWidgetEntryView: View {
    var entry: NextBusEntry

    var body: some View {
        VStack {
            Text("Next Bus:")
            if let selectedBus = entry.selectedBusSchedule {
                Text(selectedBus.arrivalTime.formatted())
                    .font(.headline)
            } else {
                Text("No schedule selected")
                    .font(.caption)
            }
        }
        .padding()
    }
}
