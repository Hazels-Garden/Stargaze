//
//  CheckedDays.swift
//  Stargaze
//
//  Created by Hazel Nishad on 16/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import SwiftData

@Model
class CheckedDays {
  var date: Date

  // Goal Tracking not included currently.

  init(date: Date) {
    self.date = date
  }
}
