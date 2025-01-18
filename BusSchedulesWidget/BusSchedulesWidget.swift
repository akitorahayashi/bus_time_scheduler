//
//  BusSchedulesWidget.swift
//  BusSchedulesWidget
//
//  Created by 林 明虎 on 2025/01/18.
//

import WidgetKit
import SwiftUI

struct BusSchedulesWidget: Widget {
    let kind: String = "BusSchedulesWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: BusSchedulesTimeLineProvider()) { entry in
            if #available(iOS 17.0, *) {
                BusSchedulesWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                BusSchedulesWidgetEntryView(entry: entry)
                    .padding()
                    .background(Color(UIColor.systemBackground))
            }
        }
        .configurationDisplayName("Bus Schedules Widget")
        .description("Displays a list of the earliest bus arrival times from the current time.")
    }
}
