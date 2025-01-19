//
//  NextBusWidgetEntryView.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import SwiftUI

struct NextBusWidgetEntryView: View {
    var entry: NextBusEntry
    @Environment(\.widgetFamily) private var family

    var body: some View {
        Group {
            switch family {
            case .systemSmall:
                SmallNextBusWidgetView(entry: entry)
            case .systemMedium:
                MediumNextBusWidgetView(entry: entry)
            default:
                // 他のサイズは対応しない（到達しない想定）
                EmptyView()
            }
        }
    }
}
