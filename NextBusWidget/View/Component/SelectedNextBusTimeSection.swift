//
//  SelectedNextBusTimeSection.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import SwiftUI

struct SelectedNextBusTimeSection: View {
    let arrivalTime: BSFixedTime?

    var body: some View {
        VStack {
            Text("Next Bus:")
            if let arrivalTime = arrivalTime {
                Text(arrivalTime.formatted())
            } else {
                Text("No schedule selected")
            }
        }
    }
}
