//
//  SelectedNextBusTimeSection.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/19.
//

import SwiftUI

struct SelectedNextBusTimeSection: View {
    let arrivalTime: String?

    var body: some View {
        VStack {
            Text(arrivalTime == nil ? "NEXT" : "SELECTED")
                .fontWeight(.bold)
                .font(.system(size: 12))
                .foregroundColor(.accent)
            Group {
                if let arrivalTime = arrivalTime {
                    // 時間が選択されている場合または最も早い時間がある場合
                    Text(arrivalTime)
                } else {
                    Text("N/A")
                }
            }
            .font(.system(size: 18))
            .fontWeight(.bold)
            .foregroundColor(.gray.opacity(0.9))
        }
    }
}
