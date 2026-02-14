//
//  DateOnly.swift
//  Stargaze
//
//  Created by Hazel Nishad on 14/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation

struct DateOnly: Codable, Hashable, Comparable {
  static func < (lhs: DateOnly, rhs: DateOnly) -> Bool {
    Date.from(year: lhs.year, month: lhs.month, day: lhs.day)! < Date.from(year: rhs.year, month: rhs.month, day: rhs.day)!
  }
  
  static func == (lhs: DateOnly, rhs: DateOnly) -> Bool {
    Date.from(year: lhs.year, month: lhs.month, day: lhs.day)! == Date.from(year: rhs.year, month: rhs.month, day: rhs.day)!
  }

  var id = UUID()
  static var calendar = Calendar(identifier: .gregorian)
  var day: Int
  var month: Int
  var year: Int
  
  init(id: UUID = UUID(), day: Int, month: Int, year: Int = DateOnly.calendar.component(.year, from: Date.now)) {
    self.id = id
    self.day = day
    self.month = month
    self.year = year
  }
  
  static func now() -> DateOnly {
    let components = Date.get(from: Date.now, with: [.day, .month, .year])
    return DateOnly(day: components.day!, month: components.month!, year: components.year!)
  }
  
  static func from(date: Date) -> DateOnly {
    let components = Date.get(from: date, with: [.day, .month, .year])
    return DateOnly(day: components.day!, month: components.month!, year: components.year!)
  }
  
  func dayOfYear() -> Int {
    let date = Date.from(
      dateOnly: DateOnly(day: self.day, month: self.month, year:self.year)
    )
    return date?.dayOfYear ?? 1
  }
}
