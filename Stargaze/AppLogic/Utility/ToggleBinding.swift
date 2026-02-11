//
//  ToggleBinding.swift
//  Stargaze
//
//  Created by Hazel Nishad on 11/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import SwiftUI
import SwiftData

struct ToggleBinding {
  var appState = AppState.shared
  var habit: Habit
  var modelContext: ModelContext

  var isChecked: Binding<Bool> {
    Binding(
      get: {
        for checkedDay in habit.checkedDays {
          if appState.getDateOnly(from: checkedDay.date)
            == appState.getDateOnly(
              from: appState.selectedDate
            )
          {
            return true
          }
        }
        return false
      },
      set: { (newValue: Bool) in
        if newValue {
          habit.checkedDays.append(CheckedDays(date: appState.selectedDate))
        } else {
          for (index, checkedDay) in habit.checkedDays.enumerated() {
            if appState.getDateOnly(from: checkedDay.date)
              == appState.getDateOnly(
                from: appState.selectedDate
              )
            {
              let removedCheckedDay = habit.checkedDays.remove(at: index)
              modelContext.delete(removedCheckedDay)
              try? modelContext.save()
            }
          }
        }
      }
    )
  }
}
