//
//  FooterStatsView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 10/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct FooterStatsView: View {
  let habit: Habit
  let showBorder: Bool
  @Environment(AppState.self) private var appState
  @State var sortedCheckedDays: [CheckedDays] = []

  var body: some View {
    Text("Streak: \(streak) • Total: \(total)")
      .SGLarge()
      .fontWidth(.compressed)
      .foregroundStyle(.secondary)
      .border(showBorder ? .purple : .clear)
      .onAppear {
        sortCheckedDaysList()
      }
      .onChange(of: habit.checkedDays) {
        sortCheckedDaysList()
      }
  }

  var streak: Int {
    var maxStreak = 0
    var curStreak = 0
    guard habit.checkedDays.count > 0 else { return 0 }
    
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
    return maxStreak
  }

  var total: Int {
    habit.checkedDays.count
  }
  
  func sortCheckedDaysList() {
    let checkedDays = habit.checkedDays
    sortedCheckedDays = checkedDays.sorted(by: { $0.date < $1.date })
  }
}

#Preview {
  FooterStatsView(
    habit: Habit(
      color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1],
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
    showBorder: false
  )
  .environment(AppState.shared)
}
