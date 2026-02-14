//
//  PeekSheetView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 12/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct PeekSheetView: View {
  let habit: Habit
  let showBorder: Bool
  @Environment(UserStats.self) private var userStats
  @Environment(AppState.self) private var appState

  func formattedStartDate(dateOnly: DateOnly?) -> String? {
    guard let notNilDateOnly = dateOnly else {
      return nil
    }
    return
      DateFormatter
      .localizedString(
        from: Date.from(dateOnly: notNilDateOnly)!,
        dateStyle: .medium,
        timeStyle: .none
      )
  }

  var startedSubtitle: String {
    if let formattedDate = self.formattedStartDate(
      dateOnly: userStats.habitStartDate
    ) {
      "Started \(formattedDate)"
    } else {
      "Not Started Yet"
    }
  }

  var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 0) {
        Text(habit.title)
          .fontWeight(.bold)
          .SGXXLarge()
          .fontWidth(.expanded)
          .lineLimit(1)

        Text(startedSubtitle)
          .SGNormal()
          .foregroundStyle(.secondary)
      }
      .padding(.bottom, 20)

      PeekStatsView(userStats: userStats)
        .padding(.bottom, 24)

      Text("Swipe up to open Observation Deck.")
        .SGSmall()
        .fontWidth(.expanded)
        .foregroundStyle(.secondary)
    }
    .border(showBorder ? .yellow : .clear)
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
  PeekSheetView(
    habit: Habit(
      color: ["hue": 0.6167, "sat": 0.91, "bri": 0.82, "opa": 1],
      checkedDays: [
        CheckedDays(date: DateOnly(day: 6, month: 1)), // 2026-01-06
        CheckedDays(date: DateOnly(day: 8, month: 1)), // 2026-01-08
        CheckedDays(date: DateOnly(day: 15, month: 1)), // 2026-01-15
        CheckedDays(date: DateOnly(day: 18, month: 1)), // 2026-01-18
        CheckedDays(date: DateOnly(day: 21, month: 1)), // 2026-01-21
        CheckedDays(date: DateOnly(day: 25, month: 1)), // 2026-01-25
        CheckedDays(date: DateOnly(day: 26, month: 1)), // 2026-01-26
        CheckedDays(date: DateOnly(day: 27, month: 1)), // 2026-01-27
        CheckedDays(date: DateOnly(day: 28, month: 1)), // 2026-01-28
        CheckedDays(date: DateOnly(day: 1, month: 2)), // 2026-02-01
        CheckedDays(date: DateOnly(day: 4, month: 2)), // 2026-02-04
        CheckedDays(date: DateOnly(day: 8, month: 2)), // 2026-02-08
        CheckedDays(date: DateOnly(day: 10, month: 2)), // 2026-02-10
        CheckedDays(date: DateOnly(day: 14, month: 2)), // 2026-02-14
      ]
    ),
    showBorder: true,
  )
  .environment(AppState.shared)
  .environment(UserStats.shared)
}
