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

  static let shared = AppState()

  let calendar = Calendar(identifier: .gregorian)
  let currentYear: Int
  var selectedYear: Int
  let currentDate: DateOnly
  var selectedDate: DateOnly

  init(
    currentYear: Int = Calendar(identifier: .gregorian).component(.year, from: .now),
    selectedYear: Int = Calendar(identifier: .gregorian).component(.year, from: .now),
    currentDate: DateOnly = DateOnly.now(),
    selectedDate: DateOnly = DateOnly.now(),
  ) {
    self.currentYear = currentYear
    self.selectedYear = selectedYear
    self.currentDate = currentDate
    self.selectedDate = selectedDate
  }

  func calculateDaysInSelectedYear() -> Int {
    let dateComponents = DateComponents(year: self.selectedYear)
    let date = calendar.date(from: dateComponents)!
    let range = calendar.range(of: .day, in: .year, for: date)!
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
    let dateString = dateFormatter.string(
      from: Date.from(dateOnly: self.selectedDate)!
    )
    return dateString
  }

  func calculateDateFromSelectedDayOfYear(dayOfYear: Int) -> DateOnly? {
    var dateComponents = DateComponents()
    dateComponents.year = self.selectedYear
    dateComponents.day = dayOfYear
    if let date = calendar.date(from: dateComponents) {
      return DateOnly.from(date: date)
    } else {
      return nil
    }
  }
}
