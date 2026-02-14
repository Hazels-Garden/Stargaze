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
        CheckedDays(date: Date.from(month: 1, day: 3)!), // 202x-01-03
        CheckedDays(date: Date.from(month: 1, day: 8)!), // 202x-01-08
        CheckedDays(date: Date.from(month: 1, day: 12)!), // 202x-01-12
        CheckedDays(date: Date.from(month: 1, day: 13)!), // 202x-01-13
        CheckedDays(date: Date.from(month: 1, day: 14)!), // 202x-01-14
        CheckedDays(date: Date.from(month: 1, day: 15)!), // 202x-01-15
        CheckedDays(date: Date.from(month: 1, day: 17)!), // 202x-01-17
        CheckedDays(date: Date.from(month: 1, day: 22)!), // 202x-01-22
        CheckedDays(date: Date.from(month: 1, day: 28)!), // 202x-01-28
        CheckedDays(date: Date.from(month: 2, day: 2)!), // 202x-02-02
        CheckedDays(date: Date.from(month: 2, day: 6)!), // 202x-02-06
        CheckedDays(date: Date.from(month: 2, day: 10)!), // 202x-02-10
        CheckedDays(date: Date.from(now: true)!)
      ]
    ),
    Habit(
      title: "Hug Bunbun",
      desc: "9:00PM • Hug Ms. Bunbun everyday",
      color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1],
      sortOrder: 1,
      checkedDays: [
        CheckedDays(date: Date.from(month: 1, day: 1)!), // 202x-01-01
        CheckedDays(date: Date.from(month: 1, day: 5)!), // 202x-01-05
        CheckedDays(date: Date.from(month: 1, day: 9)!), // 202x-01-09
        CheckedDays(date: Date.from(month: 1, day: 13)!), // 202x-01-13
        CheckedDays(date: Date.from(month: 1, day: 16)!), // 202x-01-16
        CheckedDays(date: Date.from(month: 1, day: 20)!), // 202x-01-20
        CheckedDays(date: Date.from(month: 1, day: 21)!), // 202x-01-21
        CheckedDays(date: Date.from(month: 1, day: 22)!), // 202x-01-22
        CheckedDays(date: Date.from(month: 1, day: 24)!), // 202x-01-24
        CheckedDays(date: Date.from(month: 1, day: 27)!), // 202x-01-27
        CheckedDays(date: Date.from(month: 1, day: 31)!), // 202x-01-31
        CheckedDays(date: Date.from(month: 2, day: 4)!), // 202x-02-04
        CheckedDays(date: Date.from(month: 2, day: 9)!), // 202x-02-09
        CheckedDays(date: Date.from(now: true)!)
      ]
    ),
    Habit(
      title: "Read 1 Chapter",
      desc: "12:00PM • Read 1 chapter everyday",
      color: ["hue": 0.8722, "sat": 0.81, "bri": 0.65, "opa": 1],
      sortOrder: 2,
      checkedDays: [
        CheckedDays(date: Date.from(month: 1, day: 2)!), // 202x-01-02
        CheckedDays(date: Date.from(month: 1, day: 4)!), // 202x-01-04
        CheckedDays(date: Date.from(month: 1, day: 7)!), // 202x-01-07
        CheckedDays(date: Date.from(month: 1, day: 8)!), // 202x-01-08
        CheckedDays(date: Date.from(month: 1, day: 11)!), // 202x-01-11
        CheckedDays(date: Date.from(month: 1, day: 12)!), // 202x-01-12
        CheckedDays(date: Date.from(month: 1, day: 14)!), // 202x-01-14
        CheckedDays(date: Date.from(month: 1, day: 18)!), // 202x-01-18
        CheckedDays(date: Date.from(month: 1, day: 21)!), // 202x-01-21
        CheckedDays(date: Date.from(month: 1, day: 25)!), // 202x-01-25
        CheckedDays(date: Date.from(month: 1, day: 29)!), // 202x-01-29
        CheckedDays(date: Date.from(month: 2, day: 1)!), // 202x-02-01
        CheckedDays(date: Date.from(month: 2, day: 3)!), // 202x-02-03
        CheckedDays(date: Date.from(month: 2, day: 7)!), // 202x-02-07
        CheckedDays(date: Date.from(month: 2, day: 11)!), // 202x-02-11
        CheckedDays(date: Date.from(now: true)!)
      ]
    ),
    Habit(
      title: "Watch Drake's Album",
      desc: "2:00PM • Watch Honestly Nevermind Reaction",
      color: ["hue": 0.7222, "sat": 0.81, "bri": 0.65, "opa": 1],
      sortOrder: 3,
      checkedDays: [
        CheckedDays(date: Date.from(month: 1, day: 1)!), // 202x-01-01
        CheckedDays(date: Date.from(month: 1, day: 6)!), // 202x-01-06
        CheckedDays(date: Date.from(month: 1, day: 10)!), // 202x-01-10
        CheckedDays(date: Date.from(month: 1, day: 15)!), // 202x-01-15
        CheckedDays(date: Date.from(month: 1, day: 19)!), // 202x-01-19
        CheckedDays(date: Date.from(month: 1, day: 23)!), // 202x-01-23
        CheckedDays(date: Date.from(month: 1, day: 24)!), // 202x-01-24
        CheckedDays(date: Date.from(month: 1, day: 25)!), // 202x-01-25
        CheckedDays(date: Date.from(month: 1, day: 26)!), // 202x-01-26
        CheckedDays(date: Date.from(month: 1, day: 30)!), // 202x-01-30
        CheckedDays(date: Date.from(month: 2, day: 2)!), // 202x-02-02
        CheckedDays(date: Date.from(month: 2, day: 4)!), // 202x-02-04
        CheckedDays(date: Date.from(month: 2, day: 5)!), // 202x-02-05
        CheckedDays(date: Date.from(month: 2, day: 8)!), // 202x-02-08
        CheckedDays(date: Date.from(month: 2, day: 10)!), // 202x-02-10
        CheckedDays(date: Date.from(month: 2, day: 12)!), // 202x-02-12
        CheckedDays(date: Date.from(now: true)!)
      ]
    ),
    Habit(
      title: "Make Breakfast",
      desc: "7:00AM • Make breakfast everyday",
      color: ["hue": 0, "sat": 0, "bri": 0, "opa": 0],
      sortOrder: 4,
      checkedDays: [
        CheckedDays(date: Date.from(month: 1, day: 1)!), // 202x-01-01
        CheckedDays(date: Date.from(month: 1, day: 6)!), // 202x-01-06
        CheckedDays(date: Date.from(month: 1, day: 10)!), // 202x-01-10
        CheckedDays(date: Date.from(month: 1, day: 15)!), // 202x-01-15
        CheckedDays(date: Date.from(month: 1, day: 19)!), // 202x-01-19
        CheckedDays(date: Date.from(month: 1, day: 23)!), // 202x-01-23
        CheckedDays(date: Date.from(month: 1, day: 26)!), // 202x-01-26
        CheckedDays(date: Date.from(month: 1, day: 30)!), // 202x-01-30
        CheckedDays(date: Date.from(month: 2, day: 2)!), // 202x-02-02
        CheckedDays(date: Date.from(month: 2, day: 4)!), // 202x-02-04
        CheckedDays(date: Date.from(month: 2, day: 5)!), // 202x-02-05
        CheckedDays(date: Date.from(month: 2, day: 8)!), // 202x-02-08
        CheckedDays(date: Date.from(month: 2, day: 10)!), // 202x-02-10
        CheckedDays(date: Date.from(month: 2, day: 12)!), // 202x-02-12
        CheckedDays(date: Date.from(now: true)!)
      ]
    ),
  ]

}
