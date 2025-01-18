//
//  BSDateFormatter.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/18.
//

import Foundation

final class BSDateFormatter {
    static let shared = BSDateFormatter()

    private let formatter: DateFormatter

    private init() {
        formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.autoupdatingCurrent
    }

    enum Format: String {
        case fullDate = "yyyy/MM/dd"
        case timeOnly = "HH:mm"
    }

    func formattedDate(from date: Date, format: Format) -> String {
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
}

