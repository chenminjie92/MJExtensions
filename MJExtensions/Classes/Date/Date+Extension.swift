//
//  Date+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation

extension Date: NamespaceWrappable { }
extension TypeWrapperProtocol where WrappedType == Date {
    
    
    /// 年份
    public var timeTupl: (Int, Int, Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: wrappedValue)
        return (components.year ?? 0, components.month ?? 0, components.day ?? 0)
    }
    
    /// 年份
    public var year: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: wrappedValue)
        return components.year ?? 0
    }
    
    /// 月
    public var month: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: wrappedValue)
        return components.month ?? 0
    }
    
    /// 日
    public var day: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: wrappedValue)
        return components.day ?? 0
    }
    
    /// 是否今天
    public var isToday: Bool {
        
        let calendar: Calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: wrappedValue)
        let nowComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        return components.year == nowComponents.year && components.month == nowComponents.month && components.day == nowComponents.day
    }
    
    /// 是否昨天
    public var isYesterday: Bool {
        
        let nowData = Date()
        let calendar: Calendar = Calendar.current
        let cmps: DateComponents = calendar.dateComponents([.day], from: wrappedValue, to: nowData)
        return cmps.day == 1
    }
    
    /// 是否7天内
    public var isSevenDays: Bool {
        let nowData = Date()
        let calendar: Calendar = Calendar.current
        let cmps: DateComponents = calendar.dateComponents([.day], from: wrappedValue, to: nowData)
        return (cmps.day ?? 0) <= 6
    }
    
    /// 年份
    public var yearString: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: wrappedValue)
        return "\(components.year ?? 0)"
    }
    
    /// 月
    public var monthString: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: wrappedValue)
        return String.init(format: "%02d", (components.month ?? 0))
    }
    
    /// 日
    public var dayString: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: wrappedValue)
        return String.init(format: "%02d", (components.day ?? 0))
    }
    
    /// 星期几
    public var weekDayString: String {
        let tempWeek:[String] = ["星期天","星期一","星期二","星期三","星期四","星期五","星期六"]
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: wrappedValue)
        guard let _weekday = components.weekday, _weekday <= 7 else  {
            return ""
        }
        return tempWeek[_weekday - 1]
    }
    
    
    /// 获取多少年后
    /// - Parameter year: 多少年后
    /// - Returns: date
    public func beforeDate(with year: Int) -> Date {
        let currentDate = wrappedValue
        let calendar = Calendar.init(identifier: .gregorian)
        var yearComps = DateComponents()
        yearComps.year = year
        return calendar.date(byAdding: yearComps, to: currentDate) ?? Date()
    }
    /// 返回格式化日期
    ///
    /// - Parameters:
    ///   - millionSecSince1970: 以毫秒为单位的时间戳
    ///   - formate: 格式化字符串 默认值为"YYYY-MM-dd HH:mm:ss"
    public static func dateString(millionSecSince1970: TimeInterval, format: String = "YYYY-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date(timeIntervalSince1970: millionSecSince1970/1_000))
    }
    
    // MARK: - 获取当前时区Date
    public static func getCurrentDate() -> Date {
        let nowDate = Date()
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: nowDate)
        let localeDate = nowDate.addingTimeInterval(TimeInterval(interval))
        return localeDate
    }
    
    public static func dateFromString(dateString: String?, formatter: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        guard let tdateString = dateString else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from: tdateString)
    }

    public static func stringFromDate(date: Date, formatter: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: date)
    }
    
    /// 获取当前时间戳10位
    /// - Returns: 时间戳
    public static func getCurrentTimeStamp() -> String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    public static func getCurrentData() -> String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 时间转换
    /// - Parameters:
    ///   - timeString: 时间格式化字符串
    ///   - formatter: 格式化样式
    /// - Returns: 回调结果
    public static func conversionTime(for timeString: String, formatter: String = "yyyy-MM-dd") -> Date? {
        // 实例化NSDateFormatter
        let formatterDate: DateFormatter = DateFormatter()
        // 设置日期格式
        formatterDate.dateFormat = formatter
        // 这里如果不设置为UTC时区，会把要转换的时间字符串定为当前时区的时间（东八区）转换为UTC时区的时间
        formatterDate.timeZone = NSTimeZone.system
        return formatterDate.date(from: timeString)
    }
    
    /// 格式化时间
    /// - Parameter formatter: 时间格式
    /// - Returns: 时间
    public func formatterData(for formatter: String = "yyyy-MM-dd") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: wrappedValue)
    }
    
    /// 比较2个时间是否同一天
    /// - Parameter date:对比的时间
    /// - Returns: 回调
    public func compareSameDay(for date: Date) -> Bool {
        if date.ext.year == wrappedValue.ext.year, date.ext.month == wrappedValue.ext.month, date.ext.day == wrappedValue.ext.day {
            return true
        }
        return false
    }
    
    
    /// 获取多少天后
    /// - Parameter day: 多少天
    /// - Returns: 时间
    public func getAfterDate(for day: Int) -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day,.weekday,.year,.month], from: wrappedValue)
        if let _day = components.day {
            components.day = _day + 1
        }
        return calendar.date(from: components)
    }

}
