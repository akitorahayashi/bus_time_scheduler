//
//  NextBusWidget.swift
//  NextBusWidget
//
//  Created by 林 明虎 on 2025/01/19.
//

import WidgetKit
import SwiftUI

struct NextBusWidget: Widget {
    let kind: String = "NextBusWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: NextBusTimeLineProvider()) { entry in
            if #available(iOS 17.0, *) {
                NextBusWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                NextBusWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Next Bus Widget")
        .description("Record the selected bus time and display a countdown until the next departure.")
    }
}
