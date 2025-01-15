//
//  NextBusWidgetEntryView.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import SwiftUI

struct NextBusWidgetEntryView : View {
    var entry: NextBusProvider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)
        }
    }
}
