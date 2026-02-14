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
        CheckedDays(date: Date.from(month: 1, day: 3)!),  // 202x-01-03
        CheckedDays(date: Date.from(month: 1, day: 8)!),  // 202x-01-08
        CheckedDays(date: Date.from(month: 1, day: 12)!),  // 202x-01-12
        CheckedDays(date: Date.from(month: 1, day: 13)!),  // 202x-01-13
        CheckedDays(date: Date.from(month: 1, day: 14)!),  // 202x-01-14
        CheckedDays(date: Date.from(month: 1, day: 15)!),  // 202x-01-15
        CheckedDays(date: Date.from(month: 1, day: 17)!),  // 202x-01-17
        CheckedDays(date: Date.from(month: 1, day: 22)!),  // 202x-01-22
        CheckedDays(date: Date.from(month: 1, day: 28)!),  // 202x-01-28
        CheckedDays(date: Date.from(month: 2, day: 2)!),  // 202x-02-02
        CheckedDays(date: Date.from(month: 2, day: 6)!),  // 202x-02-06
        CheckedDays(date: Date.from(month: 2, day: 10)!),  // 202x-02-10
        CheckedDays(date: Date.from(now: true)!),
      ]
    ),
    showBorder: true,
  )
  .environment(AppState.shared)
  .environment(UserStats.shared)
}
