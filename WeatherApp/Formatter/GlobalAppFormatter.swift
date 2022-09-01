//
//  GlobalAppFormatter.swift
//  WeatherApp
//
//  Created by admin on 12.05.2022.
//

import Foundation

enum AppDateVariants: String {
    case onlyTime24 = "HH:mm"
    case onlyTime12 = "hh:mm"
    case daySlashMounth = "dd/MM" // 16/04
    case dayDaySlashMounth = "E dd/MM" // пт 16/04
    case daySlashMounthDay = "dd/MM E" // 16/04 ПТ
    case fullDate = "HH:mm, E dd MMMM" // 17:05, пт 16 сентября
}

protocol AppFormatter {

}

class GlobalAppFormatter: AppFormatter {
    static let shared = GlobalAppFormatter()

    private let dateFormatter = DateFormatter()

    func formateDate(fromUNIX date: Int, to format: AppDateVariants) -> String {
        let dateInDouble = Double(date)
        let date = Date(timeIntervalSince1970: dateInDouble)

//        dateFormatter.locale = .init(identifier: "ru_RU")

        dateFormatter.locale = .current

        dateFormatter.dateFormat = format.rawValue
        let strDate = dateFormatter.string(from: date)
        return strDate
    }

    func isEquelDates(now date: Date, unixDate: Int) -> Bool {
        let unixDateInDouble = Double(unixDate)
        let dateFromUnix = Date(timeIntervalSince1970: unixDateInDouble)

        dateFormatter.dateFormat = "HH"

//        dateFormatter.locale = .init(identifier: "ru_RU")

        dateFormatter.locale = .current

        let current = dateFormatter.string(from: date)
        let unix = dateFormatter.string(from: dateFromUnix)
        if Int(current) == Int(unix) {
            return true
        } else {
            return false
        }
    }

}
