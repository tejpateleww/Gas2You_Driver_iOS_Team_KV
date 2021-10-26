//
//  Date+Extension.swift
//  Qwnched-Customer
//
//  Created by Hiral on 19/02/21.
//  Copyright © 2021 Hiral's iMac. All rights reserved.
//

import Foundation
import UIKit

enum DateFormatInputType: String {
    case fullDate = "yyyy-MM-dd HH:mm:ss"
    case dateWithOutSeconds = "yyyy-MM-dd HH:mm"
    case yyyyMMdd = "yyyy-MM-dd"
    case ddMMyyyy = "dd-MM-yyyy"
    case onlyDateType_3 = "MM-dd-yyyy"
}

enum DateFormatOutputType: String {
    case fullDate = "d MMM, yyyy h:mm a"
    case standardFullDate = "yyyy-MM-dd HH:mm:ss"
    case onlyDate = "d MMM, yyyy"
    //    case onlyMonthType1 = "d MMM yy"
    case onlyDateType_2 = "yyyy-MM-dd"
    case onlyDateType_3 = "MM/dd/yyyy"
    case onlyTime = "h:mm a"
    case onlyTime24Hours = "HH:mm"
    case dayWithMonth = "EEEE, MMM dd"
    case standardOnlyDate = "d-M-yyyy"
    case onlyNameOfDay = "EEEE"
    case MonthNameWithYear = "MMM YYYY"
    case MonthDateYear = "MMM d" //"MMM d, yyyy"
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

extension UIDatePicker {
    /// Returns the date that reflects the displayed date clamped to the `minuteInterval` of the picker.
    /// - note: Adapted from [ima747's](http://stackoverflow.com/users/463183/ima747) answer on [Stack Overflow](http://stackoverflow.com/questions/7504060/uidatepicker-with-15m-interval-but-always-exact-time-as-return-value/42263214#42263214})
    public var clampedDate: Date {
        let referenceTimeInterval = self.date.timeIntervalSinceReferenceDate
        let remainingSeconds = referenceTimeInterval.truncatingRemainder(dividingBy: TimeInterval(minuteInterval*60))
        let timeRoundedToInterval = referenceTimeInterval - remainingSeconds
        return Date(timeIntervalSinceReferenceDate: timeRoundedToInterval)
    }
}

extension Date {
    //MARK: Week related timings
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }
    var formattedStartWeekString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let startWeekDate = Date().startOfWeek else { return "" }
        return dateFormatter.string(from: startWeekDate)
    }
    var formattedEndWeekString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let endWeekDate = Date().endOfWeek else { return "" }
        return dateFormatter.string(from: endWeekDate)
    }
    var dateConvertString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM. YYYY"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let endWeekDate = Date().endOfWeek else { return "" }
        return dateFormatter.string(from: endWeekDate)
    }
    var dateConvertStringType1: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let endWeekDate = Date().endOfWeek else { return "" }
        return dateFormatter.string(from: endWeekDate)
    }
    var formattedDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    var formattedDateStartWithDay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var formattedDateStyle2: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var Date_In_DD_MM_YYYY_FORMAT: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var chatRequiredTimeZone: String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatOutputType.standardFullDate.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
         return dateFormatter.string(from: self)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }
    
    
    var dayBefore: Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
    var dayAfter: Date? {
        return Calendar.current.date(byAdding: .day, value: +1, to: self)
    }
    var lastWeekDate: Date? {
        return previousWeek()
    }
    func previousWeek() -> Date {
        return addingTimeInterval(-7*24*60*60)
    }
    
    func nextWeek() -> Date {
        return addingTimeInterval(7*24*60*60)
    }
    
    var dateValue: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var hourValue: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var monthValue: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    var dayValue: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    ///Like monday tuesday, wednesday..
    var dayOfWeekFullString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    var fullMonthDay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    var timeIn12Hours: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    
}

extension Date {
    
    func timeAgoSinceDate(isForNotification : Bool = false) -> String {
        
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        let calendar = NSCalendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Europe/London") //TimeZone.current
        
        if calendar.isDateInToday(self) {
            var title = "Today"
            if !isForNotification{
                dateFormatter.dateFormat = "h:mm a"
                title = "Today, " + dateFormatter.string(from: self)
            }
            return title
        }else if calendar.isDateInTomorrow(self) {
            var title = "Tomorrow"
            if !isForNotification{
                dateFormatter.dateFormat = "h:mm a"
                title = "Tomorrow, " + dateFormatter.string(from: self)
            }
            return title
        }else if calendar.isDateInYesterday(self) {
            var title = "Yesterday"
            if !isForNotification{
                dateFormatter.dateFormat = "h:mm a"
                title = "Yesterday, " + dateFormatter.string(from: self)
            }
            return title
            
        }else{
            if isForNotification{
                dateFormatter.dateFormat = "yyyy-MM-dd"
            }else{
                dateFormatter.dateFormat = "yyyy-MM-dd, h:mm a"
            }
            return dateFormatter.string(from: self)
        }
    }
}
