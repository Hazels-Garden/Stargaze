//
//  StatsManager.swift
//  Stargaze
//
//  Created by Hazel Nishad on 12/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

@Observable
final class UserStats {

  static let shared = UserStats(
    habit: Habit(),
    totalYear: 0,
    totalAllTime: 0,
    curStreak: 0,
    bestStreak: 0,
    habitStartDate: nil,
    sortedCheckedDaysOfSelectedYear: [],
    checkedDaysListByYear: [:],
  )

  let appState = AppState.shared
  var habit: Habit
  var totalYear: Int
  var totalAllTime: Int
  var curStreak: Int
  var bestStreak: Int
  var habitStartDate: DateOnly?
  var sortedCheckedDaysOfSelectedYear: [CheckedDays]?
  var checkedDaysListByYear: [Int: [CheckedDays]]

  private init(
    habit: Habit,
    totalYear: Int,
    totalAllTime: Int,
    curStreak: Int,
    bestStreak: Int,
    habitStartDate: DateOnly?,
    sortedCheckedDaysOfSelectedYear: [CheckedDays]?,
    checkedDaysListByYear: [Int: [CheckedDays]]
  ) {
    self.habit = habit
    self.totalYear = totalYear
    self.totalAllTime = totalAllTime
    self.curStreak = curStreak
    self.bestStreak = bestStreak
    self.habitStartDate = habitStartDate
    self.sortedCheckedDaysOfSelectedYear = sortedCheckedDaysOfSelectedYear
    self.checkedDaysListByYear = checkedDaysListByYear
  }

  // The two below are for testing
  func initHabitOnly(habit: Habit) {
    self.habit = habit
  }

  func miniInitalizeUserStats(habit: Habit) {
    self.habit = habit
    self.getCheckedDaysListByYear()
    self.getSortedCheckedDaysOfSelectedYear()
  }

  // Used most of the time
  func initalizeUserStats(habit: Habit) {
    self.habit = habit
    self.getCheckedDaysListByYear()
    self.getSortedCheckedDaysOfSelectedYear()
    self.getTotalYear()
    self.getTotalAllTime()
    self.getBestStreak()
    self.getcurrentStreak()
    self.getHabitStartDate()
  }

  func getCheckedDaysForSelectedYear() -> [CheckedDays]? {
    if let checkedDays = self.checkedDaysListByYear[
      appState.selectedYear
    ] {
      return checkedDays
    }
    return nil
  }

  func getCheckedDaysListByYear() {
    self.checkedDaysListByYear = [:]
    for checkedDay in self.habit.checkedDays {
      let yearComponent = Date.get(from: checkedDay.date, with: [.year])
      if self.checkedDaysListByYear[yearComponent.year!] == nil {
        self.checkedDaysListByYear[yearComponent.year!] = []
      }
      self.checkedDaysListByYear[yearComponent.year!]?.append(checkedDay)
    }
  }

  func getHabitStartDate() {

    guard self.totalAllTime > 0 else {
      self.habitStartDate = nil
      return
    }

    var oldestDate = Date.now
    for (_, checkedDaysList) in self.checkedDaysListByYear {
      for (_, checkedDay) in checkedDaysList.enumerated() {
        oldestDate = min(oldestDate, checkedDay.date)
        if checkedDay.date < oldestDate {
          oldestDate = checkedDay.date
        }
      }
    }
    let components = Date.get(from: oldestDate, with: [.day, .month, .year])
    self.habitStartDate = DateOnly(
      day: components.day!,
      month: components.month!,
      year: components.year!
    )
  }

  func getTotalYear() {
    self.totalYear = 0
    guard
      let checkedDays = self.getCheckedDaysForSelectedYear()
    else {
      return
    }
    self.totalYear = checkedDays.count
  }

  func getTotalAllTime() {
    self.totalAllTime = 0
    for (_, checkedDaysList) in self.checkedDaysListByYear {
      self.totalAllTime += checkedDaysList.count
    }
  }

  func getSortedCheckedDaysOfSelectedYear() {
    self.sortedCheckedDaysOfSelectedYear = nil
    guard
      let checkedDays = self.getCheckedDaysForSelectedYear()
    else {
      return
    }
    self.sortedCheckedDaysOfSelectedYear = checkedDays.sorted(by: {
      $0.date < $1.date
    })
  }

  func getcurrentStreak() {
    self.curStreak = 0
    guard let sortedCheckedDays = self.sortedCheckedDaysOfSelectedYear else {
      return
    }

    guard sortedCheckedDays.last?.date == appState.currentDate else {
      return
    }

    guard sortedCheckedDays.count > 0 else {
      return
    }

    var curStreak = 1
    let lastArrayIndex = sortedCheckedDays.count - 1

    for index in stride(
      from: lastArrayIndex,
      through: 0,
      by: -1
    ) {
      if index == 0 {
        break
      } else {
        let today = sortedCheckedDays[index].date.dayOfYear
        let yesterday = sortedCheckedDays[index - 1].date
          .dayOfYear
        if today - 1 == yesterday {
          curStreak += 1
        } else {
          break
        }
      }
    }
    self.curStreak = curStreak
  }

  func getBestStreak() {
    self.bestStreak = 0
    guard let sortedCheckedDays = self.sortedCheckedDaysOfSelectedYear else {
      return
    }

    guard sortedCheckedDays.count > 0 else {
      return
    }

    var maxStreak = 0
    var curStreak = 0

    for (index, checkedDay) in sortedCheckedDays.enumerated() {
      if index == 0 {
        curStreak = 1
      } else {
        let today = checkedDay.date.dayOfYear
        let yesterday = sortedCheckedDays[index - 1].date
          .dayOfYear
        if today - 1 == yesterday {
          curStreak += 1
        } else {
          maxStreak = max(maxStreak, curStreak)
          curStreak = 1
        }
      }
    }
    self.bestStreak = maxStreak
  }
}
