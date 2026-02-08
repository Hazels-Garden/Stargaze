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
      color: ["hue": 0.09167, "sat": 0.83, "bri": 0.84, "opa": 1],
      sortOrder: 0,
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_735_862_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_208_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_640_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_899_200)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_244_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_417_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_676_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_936_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_108_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_368_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_454_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_627_200)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_713_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_800_000)),
      ]
    ),
    Habit(
      title: "Hug Bunbun",
      desc: "9:00PM • Hug Ms. Bunbun everyday",
      color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1],
      sortOrder: 1,
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_735_776_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_035_200)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_294_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_467_200)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_726_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_812_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_072_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_331_200)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_504_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_763_200)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_022_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_281_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_540_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_713_600)),
      ]
    ),
    Habit(
      title: "Read 1 Chapter",
      desc: "12:00PM • Read 1 chapter everyday",
      color: ["hue": 0.8722, "sat": 0.81, "bri": 0.65, "opa": 1],
      sortOrder: 2,
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_735_689_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_735_948_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_121_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_380_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_553_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_726_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_985_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_158_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_417_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_590_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_849_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_108_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_368_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_627_200)),
      ]
    ),
    Habit(
      title: "Watch Drake's Album",
      desc: "2:00PM • Watch Honestly Nevermind Reaction",
      color: ["hue": 0.7222, "sat": 0.81, "bri": 0.65, "opa": 1],
      sortOrder: 3,
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_735_689_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_735_948_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_121_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_380_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_553_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_726_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_985_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_158_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_417_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_590_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_849_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_108_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_368_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_627_200)),
      ]
    ),
    Habit(
      title: "Make Breakfast",
      desc: "7:00AM • Make breakfast everyday",
      color: ["hue": 0, "sat": 0, "bri": 0, "opa": 0],
      sortOrder: 4,
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_735_948_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_208_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_380_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_553_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_812_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_985_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_244_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_504_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_676_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_849_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_022_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_281_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_454_400)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_738_713_600)),
      ]
    ),
  ]

}
