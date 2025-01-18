//
//  NextBusWidget.swift
//  NextBusWidget
//
//  Created by 林 明虎 on 2025/01/15.
//

import WidgetKit
import SwiftUI


struct NextBusWidget: Widget {
    let kind: String = "NextBusWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: NextBusProvider()) { entry in
            if #available(iOS 17.0, *) {
                // Missing argument for parameter 'widgetFamily' in call
                NextBusWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                NextBusWidgetEntryView(entry: entry)
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
            }
        }
        .configurationDisplayName("Next Bus Widget")
        .description("次に発車するバスや乗りたいバスの出発時刻を表示します")
    }
}

#Preview(as: .systemSmall) {
    NextBusWidget()
} timeline: {
    NextBusEntry(date: .now, busSchedules: Constant.busSchedules, selectedBusScheduleIndex: nil)
}


