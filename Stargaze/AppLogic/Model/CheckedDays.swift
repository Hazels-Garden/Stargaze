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
  var date: DateOnly

  // Goal Tracking not included currently.

  init(date: DateOnly) {
    self.date = date
  }
}
