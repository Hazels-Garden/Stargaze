//
//  AppStateTests.swift
//  StargazeTests
//
//  Created by Hazel Nishad on 14/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import Testing

@testable import Stargaze

@MainActor
@Suite("AppState Tests")
struct AppStateTests {

  let calendar = Calendar(identifier: .gregorian)
  let appState = AppStateDateOnly.shared

  @Test("Test the initialization")
  func testInit() async throws {
    let now = DateOnly.now()
    let curYear = calendar.component(.year, from: Date.now)
    #expect(appState.currentDate == now, "current date is equal to today")
    #expect(appState.selectedDate == now, "selected date is equal to today")
    #expect(appState.currentYear == curYear, "current year is equal to this year")
    #expect(appState.selectedYear == curYear, "selected year is equal to this year")
  }
  
  @Test("Test days in the selected year")
  func testDaysInSelectedYear() async throws {
    appState.selectedYear = 2026
    var days = appState.calculateDaysInSelectedYear()
    #expect(days == 365)
    appState.selectedYear = 2028
    days = appState.calculateDaysInSelectedYear()
    #expect(days == 366)
  }

  @Test("Test formatted date for selected date")
  func testFormattedDateForSelectedDate() async throws {
    appState.selectedDate = DateOnly(day: 1, month: 1, year: 2026)
    let formattedDate = appState.formattedDateFromSelectedDate()
    #expect(formattedDate == "Thursday, 01/01")
  }

  @Test("Test date from selected day of year")
  func testDateFromSelectedDayOfYear() async throws {
    let testDayOfYear = 34
    let dateOnly = appState.calculateDateFromSelectedDayOfYear(
      dayOfYear: testDayOfYear
    )
    #expect(dateOnly == DateOnly(day: 3, month: 2), "day of year 34 is Feb 3")
  }

}
