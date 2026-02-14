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
  @Environment(UserStats.self) private var userStats
  
  var body: some View {
    Text(
      "Total: \(userStats.totalYear) • Streak: \(userStats.curStreak)"
    )
      .SGLarge()
      .fontWidth(.compressed)
      .foregroundStyle(.secondary)
      .border(showBorder ? .purple : .clear)
      .onAppear {
        userStats.initalizeUserStats(habit: habit)
      }
      .onChange(of: habit.checkedDays) {
        userStats.initalizeUserStats(habit: habit)
      }
      .onChange(of: appState.selectedYear) {
        userStats.initalizeUserStats(habit: habit)
      }
  }
}

#Preview {
  FooterStatsView(
    habit: Habit(
      color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1],
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
    showBorder: false
  )
  .environment(AppState.shared)
  .environment(UserStats.shared)
}
