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
  var color: String?
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
      color: String? = nil,
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
}
