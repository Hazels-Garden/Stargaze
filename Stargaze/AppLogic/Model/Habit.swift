//
//  Habit.swift
//  Stargaze
//
//  Created by Hazel Nishad on 16/1/26.
//  Copyright © 202x Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import SwiftData

@Model
class Habit {
  @Attribute(.unique) var id: UUID
  var title: String
  var desc: String
  var color: [String: Double]
  var shouldRemind: Bool
  var reminderHour: Int
  var reminderMintute: Int
  var archiveTime: Date?
  var sortOrder: Int
  @Relationship(deleteRule: .cascade) var checkedDays = [CheckedDays]()

  // Frequency and Goal Tracking not included currently.

  init(
    id: UUID = UUID(),
    title: String = "Stargaze, by Hazel.",
    desc: String = "9:00AM • Love you, hazelbunny",
    color: [String: Double] = ["hue": 0, "sat": 0, "bri": 0, "opa": 0],
    shouldRemind: Bool = false,
    reminderHour: Int = 0,
    reminderMintute: Int = 0,
    archiveTime: Date? = nil,
    sortOrder: Int = 0,
    checkedDays: [CheckedDays] = [CheckedDays]()
  ) {
    self.id = id
    self.title = title
    self.desc = desc
    self.color = color
    self.shouldRemind = shouldRemind
    self.reminderHour = reminderHour
    self.reminderMintute = reminderMintute
    self.archiveTime = archiveTime
    self.sortOrder = sortOrder
    self.checkedDays = checkedDays
  }

  static let sampleData = [
    Habit(
      title: "Run 5k",
      desc: "9:00AM • Run at least 5k everyday",
      color: ["hue": 0.0667, "sat": 0.83, "bri": 0.84, "opa": 1],
      sortOrder: 0,
      checkedDays: [
        CheckedDays(date: DateOnly(day: 2, month: 1)), // 2026-01-02
        CheckedDays(date: DateOnly(day: 5, month: 1)), // 2026-01-05
        CheckedDays(date: DateOnly(day: 9, month: 1)), // 2026-01-09
        CheckedDays(date: DateOnly(day: 16, month: 1)), // 2026-01-16
        CheckedDays(date: DateOnly(day: 17, month: 1)), // 2026-01-17
        CheckedDays(date: DateOnly(day: 18, month: 1)), // 2026-01-18
        CheckedDays(date: DateOnly(day: 23, month: 1)), // 2026-01-23
        CheckedDays(date: DateOnly(day: 27, month: 1)), // 2026-01-27
        CheckedDays(date: DateOnly(day: 31, month: 1)), // 2026-01-31
        CheckedDays(date: DateOnly(day: 4, month: 2)), // 2026-02-04
        CheckedDays(date: DateOnly(day: 9, month: 2)), // 2026-02-09
        CheckedDays(date: DateOnly(day: 13, month: 2)), // 2026-02-13
      ]
    ),
    Habit(
      title: "Hug Bunbun",
      desc: "9:00PM • Hug Ms. Bunbun everyday",
      color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1],
      sortOrder: 1,
      checkedDays: [
        CheckedDays(date: DateOnly(day: 3, month: 1)), // 2026-01-03
        CheckedDays(date: DateOnly(day: 7, month: 1)), // 2026-01-07
        CheckedDays(date: DateOnly(day: 11, month: 1)), // 2026-01-11
        CheckedDays(date: DateOnly(day: 14, month: 1)), // 2026-01-14
        CheckedDays(date: DateOnly(day: 19, month: 1)), // 2026-01-19
        CheckedDays(date: DateOnly(day: 20, month: 1)), // 2026-01-20
        CheckedDays(date: DateOnly(day: 21, month: 1)), // 2026-01-21
        CheckedDays(date: DateOnly(day: 22, month: 1)), // 2026-01-22
        CheckedDays(date: DateOnly(day: 26, month: 1)), // 2026-01-26
        CheckedDays(date: DateOnly(day: 30, month: 1)), // 2026-01-30
        CheckedDays(date: DateOnly(day: 3, month: 2)), // 2026-02-03
        CheckedDays(date: DateOnly(day: 7, month: 2)), // 2026-02-07
        CheckedDays(date: DateOnly(day: 11, month: 2)), // 2026-02-11
      ]
    ),
    Habit(
      title: "Read 1 Chapter",
      desc: "12:00PM • Read 1 chapter everyday",
      color: ["hue": 0.8722, "sat": 0.81, "bri": 0.65, "opa": 1],
      sortOrder: 2,
      checkedDays: [
        CheckedDays(date: DateOnly(day: 1, month: 1)), // 2026-01-01
        CheckedDays(date: DateOnly(day: 4, month: 1)), // 2026-01-04
        CheckedDays(date: DateOnly(day: 10, month: 1)), // 2026-01-10
        CheckedDays(date: DateOnly(day: 11, month: 1)), // 2026-01-11
        CheckedDays(date: DateOnly(day: 12, month: 1)), // 2026-01-12
        CheckedDays(date: DateOnly(day: 13, month: 1)), // 2026-01-13
        CheckedDays(date: DateOnly(day: 14, month: 1)), // 2026-01-14
        CheckedDays(date: DateOnly(day: 24, month: 1)), // 2026-01-24
        CheckedDays(date: DateOnly(day: 29, month: 1)), // 2026-01-29
        CheckedDays(date: DateOnly(day: 5, month: 2)), // 2026-02-05
        CheckedDays(date: DateOnly(day: 12, month: 2)), // 2026-02-12
      ]
    ),
    Habit(
      title: "Watch Drake's Album",
      desc: "2:00PM • Watch Honestly Nevermind Reaction",
      color: ["hue": 0.7222, "sat": 0.81, "bri": 0.65, "opa": 1],
      sortOrder: 3,
      checkedDays: [
        CheckedDays(date: DateOnly(day: 6, month: 1)), // 2026-01-06
        CheckedDays(date: DateOnly(day: 8, month: 1)), // 2026-01-08
        CheckedDays(date: DateOnly(day: 15, month: 1)), // 2026-01-15
        CheckedDays(date: DateOnly(day: 18, month: 1)), // 2026-01-18
        CheckedDays(date: DateOnly(day: 21, month: 1)), // 2026-01-21
        CheckedDays(date: DateOnly(day: 25, month: 1)), // 2026-01-25
        CheckedDays(date: DateOnly(day: 26, month: 1)), // 2026-01-26
        CheckedDays(date: DateOnly(day: 27, month: 1)), // 2026-01-27
        CheckedDays(date: DateOnly(day: 28, month: 1)), // 2026-01-28
        CheckedDays(date: DateOnly(day: 1, month: 2)), // 2026-02-01
        CheckedDays(date: DateOnly(day: 4, month: 2)), // 2026-02-04
        CheckedDays(date: DateOnly(day: 8, month: 2)), // 2026-02-08
        CheckedDays(date: DateOnly(day: 10, month: 2)), // 2026-02-10
        CheckedDays(date: DateOnly(day: 14, month: 2)), // 2026-02-14
      ]
    ),
    Habit(
      title: "Make Breakfast",
      desc: "7:00AM • Make breakfast everyday",
      color: ["hue": 0, "sat": 0, "bri": 0, "opa": 0],
      sortOrder: 4,
      checkedDays: [
        CheckedDays(date: DateOnly(day: 2, month: 1)), // 2026-01-02
        CheckedDays(date: DateOnly(day: 3, month: 1)), // 2026-01-03
        CheckedDays(date: DateOnly(day: 4, month: 1)), // 2026-01-04
        CheckedDays(date: DateOnly(day: 5, month: 1)), // 2026-01-05
        CheckedDays(date: DateOnly(day: 12, month: 1)), // 2026-01-12
        CheckedDays(date: DateOnly(day: 17, month: 1)), // 2026-01-17
        CheckedDays(date: DateOnly(day: 23, month: 1)), // 2026-01-23
        CheckedDays(date: DateOnly(day: 29, month: 1)), // 2026-01-29
        CheckedDays(date: DateOnly(day: 2, month: 2)), // 2026-02-02
        CheckedDays(date: DateOnly(day: 6, month: 2)), // 2026-02-06
      ]
    ),
  ]

}
