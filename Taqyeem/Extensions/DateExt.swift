//
//  DateExt.swift
//  GVS Teacher
//
//  Created by sameh on 7/18/18.
//  Copyright © 2018 Hussam Elsadany. All rights reserved.
//

import Foundation

// Relative time
extension Date
{
    var yearsFromNow: Int { return Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0 }
    var monthsFromNow: Int { return Calendar.current.dateComponents([.month], from: self, to: Date()).month ?? 0 }
    var weeksFromNow: Int { return Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0 }
    var daysFromNow: Int { return Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0 }
    var hoursFromNow: Int { return Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0 }
    var minutesFromNow: Int { return Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0 }
    var secondsFromNow: Int { return Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0 }

    var relativeTime: String
    {
        if yearsFromNow > 0 { return "\(yearsFromNow) year" + (yearsFromNow > 1 ? "s" : "") + " ago" }
        if monthsFromNow > 0 { return "\(monthsFromNow) month" + (monthsFromNow > 1 ? "s" : "") + " ago" }
        if weeksFromNow > 0 { return "\(weeksFromNow) week" + (weeksFromNow > 1 ? "s" : "") + " ago" }
        if daysFromNow > 0 { return daysFromNow == 1 ? "Yesterday" : "\(daysFromNow) days ago" }
        if hoursFromNow > 0 { return "\(hoursFromNow) hour" + (hoursFromNow > 1 ? "s" : "") + " ago" }
        if minutesFromNow > 0 { return "\(minutesFromNow) minute" + (minutesFromNow > 1 ? "s" : "") + " ago" }
        if secondsFromNow > 0 { return secondsFromNow < 15 ? "Just now"
            : "\(secondsFromNow) second" + (secondsFromNow > 1 ? "s" : "") + " ago" }
        return ""
    }
}

extension Date
{
    static var current: Date
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        var comp = DateComponents()
        let calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        comp.day = Calendar.current.component(.day, from: date)
        comp.month = Calendar.current.component(.month, from: date)
        comp.year = Calendar.current.component(.year, from: date)
        comp.hour = Calendar.current.component(.hour, from: date)
        comp.minute = Calendar.current.component(.minute, from: date)
        comp.second = Calendar.current.component(.second, from: date)
        comp.nanosecond = Calendar.current.component(.nanosecond, from: date)
        comp.timeZone = TimeZone(abbreviation: "GMT+0:00")!

        return calendar.date(from: comp)!
    }

    enum FormattedDate: String
    {
        case long = "yyyy-MM-dd"
        case reversed = "dd/MM/yyyy"
        case short = "dd MMM"
        case dateTime = "yyyy-MM-dd h:mm a"
        case time = "h:mm a"
        case timeTwentyFour = "HH:mm"
        case creditCardDate = "mm/yy"
        case fullDate = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case normal = "dd/MM/yyyy HH:mm:ss"
    }

    func getDate(type: FormattedDate) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        let newDateString = dateFormatter.string(from: self)
        return newDateString
    }

    static func getCurrentYear() -> Int
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let strMonth = dateFormatter.string(from: Date())
        return Int(strMonth) ?? 0
    }
}

extension String
{
    func parseDate(format: Date.FormattedDate) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }

    func parseLongDate(withHours: Bool = true) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd\(withHours ? " HH:mm:ss" : "")"

        let date = dateFormatter.date(from: self)
        return date!
    }

    func getShortDate() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let date = dateFormatter.date(from: self) ?? Date.current

        dateFormatter.dateFormat = "yyyy-MM-dd" // Your New Date format as per requirement change it own
        let newDate = dateFormatter.string(from: date) // pass Date here
        return newDate
    }


}
