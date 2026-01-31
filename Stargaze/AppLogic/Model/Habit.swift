//
//  Habit.swift
//  Stargaze
//
//  Created by Hazel Nishad on 16/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import SwiftData

@Model
class Habit {
  var id: UUID
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
    desc: String = "Hello, and welcome!",
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
      color: ["hue": 0.09167, "sat": 0.83, "bri": 0.84, "opa": 1],
      sortOrder: 0
    ),
    Habit(
      title: "Hug Bunbun",
      desc: "9:00PM • Hug Ms. Bunbun everyday",
      color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1],
      sortOrder: 1
    ),
    Habit(
      title: "Read 1 Chapter",
      desc: "12:00PM • Read 1 chapter everyday",
      color: ["hue": 0.8722, "sat": 0.81, "bri": 0.65, "opa": 1],
      sortOrder: 2
    ),
    Habit(
      title: "Make Breakfast",
      desc: "7:00AM • Make breakfast everyday",
      color: ["hue": 0, "sat": 0, "bri": 0, "opa": 0],
      sortOrder: 3
    ),
  ]

}
