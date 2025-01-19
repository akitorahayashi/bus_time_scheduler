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
                .padding(.bottom, 1)
            
            SelectedNextBusTimeSection(arrivalTime: entry.selectedBusSchedule?.arrivalTime)
            
            Divider()
                .padding(.all, 0.2)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.accent)
                )
            
            CountdownSection(arrivalTime: entry.selectedBusSchedule?.arrivalTime, referenceDate: entry.date)
        }
        .padding()
    }
}
