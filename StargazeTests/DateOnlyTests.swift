//
//  DateOnlyTests.swift
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
@Suite("DateOnly Tests")
struct DateOnlyTests {

  let calendar = Calendar(identifier: .gregorian)

  @Test("Test the now initialization")
  func testNowInit() async throws {
    let now = DateOnly.now()
    let testAgainstDateComponents = Date.get(from: Date.now, with: [.day, .month, .year])
    #expect(
      now.day == testAgainstDateComponents.day && now.month == testAgainstDateComponents.month
        && now.year == testAgainstDateComponents.year
    )
  }

  @Test("Test DateOnly comparision")
  func testComparision() async throws {
    let lhs = DateOnly(day: 1, month: 1, year: 2026)
    let rhs = DateOnly(day: 2, month: 1, year: 2026)
    let rhsEqual = DateOnly(day: 2, month: 1, year: 2026)
    #expect(lhs < rhs)
    #expect(rhs > lhs)
    #expect(rhs == rhsEqual)
  }

  @Test("Test DateOnly init without the year")
  func testYearlessInit() async throws {
    let date = DateOnly(day: 1, month: 1)
    let testAgainstDate = Date.from(month: 1, day: 1)
    let testAgainstDateComponents = Date.get(
      from: testAgainstDate!,
      with: [.day, .month, .year]
    )
    #expect(
      date.day == testAgainstDateComponents.day
        && date.month == testAgainstDateComponents.month
        && date.year == testAgainstDateComponents.year
    )
  }

  @Test("Test DateOnly init from a Date")
  func testFromDateInit() async throws {
    let date = DateOnly.from(date: Date.now)
    let testAgainstDateComponents = Date.get(from: Date.now, with: [.day, .month, .year])
    #expect(
      date.day == testAgainstDateComponents.day
        && date.month == testAgainstDateComponents.month
        && date.year == testAgainstDateComponents.year
    )
  }

  @Test("Test to previous day")
  func testToPreviousDay() async throws {
    var date = DateOnly(day: 1, month: 1, year: 2026)
    date.toPreviousDay()
    let testAgainstDate = DateOnly(day: 31, month: 12, year: 2025)
    #expect(
      date.day == testAgainstDate.day
        && date.month == testAgainstDate.month
        && date.year == testAgainstDate.year
    )
  }

  @Test("Test to next day")
  func testToNextDay() async throws {
    var date = DateOnly(day: 31, month: 1, year: 2026)
    date.toNextDay()
    let testAgainstDate = DateOnly(day: 1, month: 2, year: 2026)
    #expect(
      date.day == testAgainstDate.day
      && date.month == testAgainstDate.month
      && date.year == testAgainstDate.year
    )
  }

}
