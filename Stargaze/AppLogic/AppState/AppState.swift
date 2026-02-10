//
//  AppState.swift
//  Stargaze
//
//  Created by Hazel Nishad on 8/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class AppState {

  static let shared = AppState(
    currentYear: Calendar.current.component(.year, from: .now),
    selectedYear: Calendar.current.component(.year, from: .now),
    currentDate: Date.now,
    selectedDate: Date.now,
  )

  let currentYear: Int
  var selectedYear: Int
  let currentDate: Date
  var selectedDate: Date

  private init(
    currentYear: Int,
    selectedYear: Int,
    currentDate: Date,
    selectedDate: Date,
  ) {
    self.currentYear = currentYear
    self.selectedYear = selectedYear
    self.currentDate = currentDate
    self.selectedDate = selectedDate
  }

  func calculateDaysInSelectedYear() -> Int {
    let dateComponents = DateComponents(year: self.selectedYear)
    let date = Calendar.current.date(from: dateComponents)!
    let range = Calendar.current.range(of: .day, in: .year, for: date)!
    return range.count
  }

  func formattedDateFromSelectedDate() -> String {
    let dateFormatter = DateFormatter()
    let userLocaleDateFormat = DateFormatter.dateFormat(
      fromTemplate: "MMdd",
      options: 0,
      locale: Locale.current
    )
    dateFormatter.dateFormat = "EEEE, \(userLocaleDateFormat ?? "01/01")"
    let dateString = dateFormatter.string(from: self.selectedDate)
    return dateString
  }

  func calculateDateFromSelectedDayOfYear(dayOfYear: Int) -> Date? {
    var dateComponents = DateComponents()
    dateComponents.year = self.selectedYear
    dateComponents.day = dayOfYear
    return Calendar.current.date(from: dateComponents)
  }

  func getDateOnly(from date: Date) -> DateComponents {
    let calender = Calendar.current
    return calender.dateComponents(
      [.year, .month, .day],
      from: date
    )
  }

}
