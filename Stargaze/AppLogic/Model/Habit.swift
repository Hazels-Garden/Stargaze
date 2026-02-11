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
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_249_000)),  // 2026-01-01
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_335_400)),  // 2026-01-02
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_421_800)),  // 2026-01-03
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_681_000)),  // 2026-01-06
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_767_400)),  // 2026-01-07
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_853_800)),  // 2026-01-08
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_940_200)),  // 2026-01-09
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_458_600)),  // 2026-01-15
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_545_000)),  // 2026-01-16
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_631_400)),  // 2026-01-17
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_717_800)),  // 2026-01-18
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_581_800)),  // 2026-01-28
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_100_200)),  // 2026-02-03
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_532_200)),  // 2026-02-08
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_618_600)),  // 2026-02-09
      ]
    ),
    Habit(
      title: "Hug Bunbun",
      desc: "9:00PM • Hug Ms. Bunbun everyday",
      color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1],
      sortOrder: 1,
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_249_000)),  // 2026-01-01
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_335_400)),  // 2026-01-02
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_681_000)),  // 2026-01-06
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_285_800)),  // 2026-01-13
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_458_600)),  // 2026-01-15
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_717_800)),  // 2026-01-18
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_322_600)),  // 2026-01-25
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_409_000)),  // 2026-01-26
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_495_400)),  // 2026-01-27
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_581_800)),  // 2026-01-28
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_668_200)),  // 2026-01-29
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_841_000)),  // 2026-01-31
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_186_600)),  // 2026-02-04
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_273_000)),  // 2026-02-05
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_532_200)),  // 2026-02-08
      ]
    ),
    Habit(
      title: "Read 1 Chapter",
      desc: "12:00PM • Read 1 chapter everyday",
      color: ["hue": 0.8722, "sat": 0.81, "bri": 0.65, "opa": 1],
      sortOrder: 2,
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_508_200)),  // 2026-01-04
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_681_000)),  // 2026-01-06
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_767_400)),  // 2026-01-07
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_940_200)),  // 2026-01-09
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_026_600)),  // 2026-01-10
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_199_400)),  // 2026-01-12
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_372_200)),  // 2026-01-14
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_717_800)),  // 2026-01-18
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_890_600)),  // 2026-01-20
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_063_400)),  // 2026-01-22
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_322_600)),  // 2026-01-25
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_581_800)),  // 2026-01-28
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_754_600)),  // 2026-01-30
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_532_200)),  // 2026-02-08
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_618_600)),  // 2026-02-09
      ]
    ),
    Habit(
      title: "Watch Drake's Album",
      desc: "2:00PM • Watch Honestly Nevermind Reaction",
      color: ["hue": 0.7222, "sat": 0.81, "bri": 0.65, "opa": 1],
      sortOrder: 3,
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_335_400)),  // 2026-01-02
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_421_800)),  // 2026-01-03
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_681_000)),  // 2026-01-06
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_853_800)),  // 2026-01-08
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_285_800)),  // 2026-01-13
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_804_200)),  // 2026-01-19
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_063_400)),  // 2026-01-22
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_149_800)),  // 2026-01-23
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_236_200)),  // 2026-01-24
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_322_600)),  // 2026-01-25
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_754_600)),  // 2026-01-30
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_186_600)),  // 2026-02-04
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_273_000)),  // 2026-02-05
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_359_400)),  // 2026-02-06
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_618_600)),  // 2026-02-09
      ]
    ),
    Habit(
      title: "Make Breakfast",
      desc: "7:00AM • Make breakfast everyday",
      color: ["hue": 0, "sat": 0, "bri": 0, "opa": 0],
      sortOrder: 4,
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_335_400)),  // 2026-01-02
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_421_800)),  // 2026-01-03
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_681_000)),  // 2026-01-06
        CheckedDays(date: Date(timeIntervalSince1970: 1_767_853_800)),  // 2026-01-08
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_285_800)),  // 2026-01-13
        CheckedDays(date: Date(timeIntervalSince1970: 1_768_804_200)),  // 2026-01-19
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_063_400)),  // 2026-01-22
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_149_800)),  // 2026-01-23
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_236_200)),  // 2026-01-24
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_322_600)),  // 2026-01-25
        CheckedDays(date: Date(timeIntervalSince1970: 1_769_754_600)),  // 2026-01-30
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_186_600)),  // 2026-02-04
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_273_000)),  // 2026-02-05
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_359_400)),  // 2026-02-06
        CheckedDays(date: Date(timeIntervalSince1970: 1_770_618_600)),  // 2026-02-09
      ]
    ),
  ]

}
