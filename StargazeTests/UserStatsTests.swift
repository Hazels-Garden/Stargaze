//
//  UserStatsTests.swift
//  UserStatsTests
//
//  Created by Hazel Nishad on 10/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import Testing

@testable import Stargaze

@MainActor
@Suite("UserStats Tests")
struct UserStatsTests {

  let calendar = Calendar(identifier: .gregorian)

  let testingData = [
    Habit(
      title: "Run 5k",
      desc: "9:00AM • Run at least 5k everyday",
      color: ["hue": 0.0667, "sat": 0.83, "bri": 0.84, "opa": 1],
      sortOrder: 0,
      checkedDays: [
        CheckedDays(date: DateOnly(day: 1, month: 1, year: 2025)),  // 2025-01-01
        CheckedDays(date: DateOnly(day: 1, month: 1)),  // 2026-01-01 (or whatever current year)
        CheckedDays(date: DateOnly(day: 2, month: 1)),  // 2026-01-02 (or whatever current year)
        CheckedDays(date: DateOnly(day: 5, month: 1)),  // 2026-01-05 (or whatever current year)
        CheckedDays(date: DateOnly(day: 6, month: 1)),  // 2026-01-06 (or whatever current year)
        CheckedDays(date: DateOnly(day: 7, month: 1)),  // 2026-01-07 (or whatever current year)
        CheckedDays(date: DateOnly(day: 8, month: 1)),  // 2026-01-08 (or whatever current year)
        CheckedDays(date: DateOnly.now()),  // today
      ]
    )
  ]

  let userStats = UserStats.shared

  @Test("Test Initialization of userStats")
  func testInitialization() async throws {
    userStats.initalizeUserStats(habit: testingData[0])
    #expect(userStats.totalYear != 0)
    #expect(userStats.totalAllTime != 0)
    #expect(userStats.curStreak != 0, "Current Streak is date dependant")
    #expect(userStats.bestStreak != 0)
    #expect(userStats.habitStartDate != nil)
    #expect(userStats.sortedCheckedDaysOfSelectedYear != [])
    #expect(userStats.checkedDaysListByYear != [:])
  }

  @Test("Test total year user stats")
  func testTotalYear() async throws {
    userStats.miniInitalizeUserStats(habit: testingData[0])
    userStats.getTotalYear()
    #expect(
      userStats.totalYear == 7,
      "The current year count in testingData is 7"
    )
  }

  @Test("Test total all time user stats")
  func testTotalAllTime() async throws {
    userStats.miniInitalizeUserStats(habit: testingData[0])
    userStats.getTotalAllTime()
    #expect(userStats.totalAllTime == 8, "The total count in testingData is 8")
  }

  @Test("Test best streak user stats")
  func testBestStreak() async throws {
    userStats.miniInitalizeUserStats(habit: testingData[0])
    userStats.getBestStreak()
    #expect(userStats.bestStreak == 4, "The best streak is from Jan 5 to Jan 8")
  }

  @Test("Test current streak user stats")
  func testCurrentStreak() async throws {
    userStats.miniInitalizeUserStats(habit: testingData[0])
    userStats.getcurrentStreak()
    #expect(
      userStats.curStreak == 1,
      "Unless it's Jan 5-8, this test should pass (fix pls)"
    )
  }

  @Test("Test habit start date user stats")
  func testHabitStartDate() async throws {
    userStats.miniInitalizeUserStats(habit: testingData[0])
    userStats.getHabitStartDate()
    #expect(
      userStats.habitStartDate == DateOnly(day: 1, month: 1, year: 2025)
    )
  }

  @Test("Test checked days list by year")
  func testCheckedDaysListByYear() async throws {
    var testCheckedDaysDateList: [DateOnly] = []
    let testAgainstDates = [
      DateOnly(day: 1, month: 1, year: 2025),  // 2025-01-01
      DateOnly(day: 1, month: 1),  // 2026-01-01 (or whatever current year)
      DateOnly(day: 2, month: 1),  // 2026-01-02 (or whatever current year)
      DateOnly(day: 5, month: 1),  // 2026-01-05 (or whatever current year)
      DateOnly(day: 6, month: 1),  // 2026-01-06 (or whatever current year)
      DateOnly(day: 7, month: 1),  // 2026-01-07 (or whatever current year)
      DateOnly(day: 8, month: 1),  // 2026-01-08 (or whatever current year)
      DateOnly.now(),
    ]
    userStats.initHabitOnly(habit: testingData[0])
    userStats.getCheckedDaysListByYear()
    for (year, checkedDaysList) in userStats.checkedDaysListByYear {
      #expect(year == 2025 || year == DateOnly.now().year)
      for checkedDay in checkedDaysList {
        testCheckedDaysDateList.append(checkedDay.date)
      }
    }

    // need testCheckedDaysDateList to be sorted
    let sortedTestDates = testCheckedDaysDateList.sorted()

    for (index, testCheckedDayDate) in sortedTestDates.enumerated() {
      #expect(testCheckedDayDate == testAgainstDates[index])
    }
  }

  @Test("Test checked days for selected year")
  func testCheckedDaysForSelectedYear() async throws {
    var testCheckedDaysDateList: [DateOnly] = []
    let testAgainstDates = [
      DateOnly(day: 1, month: 1),  // 2026-01-01 (or whatever current year)
      DateOnly(day: 2, month: 1),  // 2026-01-02 (or whatever current year)
      DateOnly(day: 5, month: 1),  // 2026-01-05 (or whatever current year)
      DateOnly(day: 6, month: 1),  // 2026-01-06 (or whatever current year)
      DateOnly(day: 7, month: 1),  // 2026-01-07 (or whatever current year)
      DateOnly(day: 8, month: 1),  // 2026-01-08 (or whatever current year)
      DateOnly.now(),
    ]
    userStats.initHabitOnly(habit: testingData[0])
    if let result = userStats.getCheckedDaysForSelectedYear() {
      for res in result {
        testCheckedDaysDateList.append(res.date)
      }
    }

    // need testCheckedDaysDateList to be sorted
    let sortedTestDates = testCheckedDaysDateList.sorted()

    for (index, testCheckedDayDate) in sortedTestDates.enumerated() {
      #expect(testCheckedDayDate == testAgainstDates[index])
    }
  }

  @Test("Test sorted checked days for selected year")
  func testSortedCheckedDaysForSelectedYear() async throws {
    var testCheckedDaysDateList: [DateOnly] = []
    let testAgainstDates = [
      DateOnly(day: 1, month: 1),  // 2026-01-01 (or whatever current year)
      DateOnly(day: 2, month: 1),  // 2026-01-02 (or whatever current year)
      DateOnly(day: 5, month: 1),  // 2026-01-05 (or whatever current year)
      DateOnly(day: 6, month: 1),  // 2026-01-06 (or whatever current year)
      DateOnly(day: 7, month: 1),  // 2026-01-07 (or whatever current year)
      DateOnly(day: 8, month: 1),  // 2026-01-08 (or whatever current year)
      DateOnly.now(),
    ]
    userStats.initHabitOnly(habit: testingData[0])
    userStats.getCheckedDaysListByYear()
    userStats.getSortedCheckedDaysOfSelectedYear()
    if let result = userStats.sortedCheckedDaysOfSelectedYear {
      for res in result {
        testCheckedDaysDateList.append(res.date)
      }
    }

    for (index, testCheckedDayDate) in testCheckedDaysDateList.enumerated() {
      #expect(testCheckedDayDate == testAgainstDates[index])
    }
  }

  //  Missing Test Cases
  //
  //  Empty habit (no checked days)
  //  Single day habit
  //  Multi-year streaks
  //  Gaps in streaks
  //  Invalid/future dates
}
