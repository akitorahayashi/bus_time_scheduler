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
        VStack {
            Text("Rendered at:")
                .font(.caption)
                .foregroundColor(.gray)
            Text(entry.date.formatted(date: .omitted, time: .shortened))
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 1)
            
            VStack(spacing: 8) {
                SelectedNextBusTimeSection(arrivalTime: entry.arrivalTimeString ?? entry.nextAvailableTime(from: entry.date))
                
                Divider()
                    .padding(.all, 1)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.accent)
                    )
                
                CountdownSection(arrivalTime: entry.arrivalTimeString ?? entry.nextAvailableTime(from: entry.date), referenceDate: entry.date)
            }
        }
    }
}
