//
//  DateExtensions.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import Foundation

extension Date {
  
  /// SwifterSwift: User’s current calendar.
  public var calendar: Calendar {
    return Calendar.current
  }
  
  /// SwifterSwift: Era.
  ///
  ///    Date().era -> 1
  ///
  public var era: Int {
    return Calendar.current.component(.era, from: self)
  }

  
  /// SwifterSwift: Year.

  public var year: Int {
    get {
      return Calendar.current.component(.year, from: self)
    }
    set {
      guard newValue > 0 else { return }
      let currentYear = Calendar.current.component(.year, from: self)
      let yearsToAdd = newValue - currentYear
      if let date = Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self) {
        self = date
      }
    }
  }
  
  /// SwifterSwift: Month.

  public var month: Int {
    get {
      return Calendar.current.component(.month, from: self)
    }
    set {
      let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
      guard allowedRange.contains(newValue) else { return }
      
      let currentMonth = Calendar.current.component(.month, from: self)
      let monthsToAdd = newValue - currentMonth
      if let date = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self) {
        self = date
      }
    }
  }
  
  /// SwifterSwift: Day.
  
  public var day: Int {
    get {
      return Calendar.current.component(.day, from: self)
    }
    set {
      let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
      guard allowedRange.contains(newValue) else { return }
      
      let currentDay = Calendar.current.component(.day, from: self)
      let daysToAdd = newValue - currentDay
      if let date = Calendar.current.date(byAdding: .day, value: daysToAdd, to: self) {
        self = date
      }
    }
  }
  
  /// SwifterSwift: Hour.

  public var hour: Int {
    get {
      return Calendar.current.component(.hour, from: self)
    }
    set {
      let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
      guard allowedRange.contains(newValue) else { return }
      
      let currentHour = Calendar.current.component(.hour, from: self)
      let hoursToAdd = newValue - currentHour
      if let date = Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self) {
        self = date
      }
    }
  }
  
  /// SwifterSwift: Minutes.

  public var minute: Int {
    get {
      return Calendar.current.component(.minute, from: self)
    }
    set {
      let allowedRange = Calendar.current.range(of: .minute, in: .hour, for: self)!
      guard allowedRange.contains(newValue) else { return }
      
      let currentMinutes = Calendar.current.component(.minute, from: self)
      let minutesToAdd = newValue - currentMinutes
      if let date = Calendar.current.date(byAdding: .minute, value: minutesToAdd, to: self) {
        self = date
      }
    }
  }
  
  public var second: Int {
    get {
      return Calendar.current.component(.second, from: self)
    }
    set {
      let allowedRange = Calendar.current.range(of: .second, in: .minute, for: self)!
      guard allowedRange.contains(newValue) else { return }
      
      let currentSeconds = Calendar.current.component(.second, from: self)
      let secondsToAdd = newValue - currentSeconds
      if let date = Calendar.current.date(byAdding: .second, value: secondsToAdd, to: self) {
        self = date
      }
    }
  }

}
// MARK: - Initializers

extension Date {
  /// Create date object from string. (Thanks to Swifter)

  public init?(dateString: String, format: String = "yyyy-MM-dd HH:mm:ss") {
    let dateFormatter = DateFormatter()
//    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = format
    if let date = dateFormatter.date(from: dateString) {
      self = date
    } else {
      return nil
    }
  }
  
  public init?(
    calendar: Calendar? = Calendar.current,
    timeZone: TimeZone? = TimeZone(abbreviation: "UTC"), //TimeZone.current,
    era: Int? = Date().era,
    year: Int? = Date().year,
    month: Int? = Date().month,
    day: Int? = Date().day,
    hour: Int? = Date().hour,
    minute: Int? = Date().minute,
    second: Int? = Date().second) {
    
    var components = DateComponents()
    components.calendar = calendar
    components.timeZone = timeZone
    components.era = era
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.second = second
    
    if let date = calendar?.date(from: components) {
      self = date
    } else {
      return nil
    }
  }
}
