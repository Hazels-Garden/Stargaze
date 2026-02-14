//
//  FooterView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 17/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftData
import SwiftUI

struct FooterView: View {

  let habit: Habit
  let showBorder: Bool
  @Environment(\.modelContext) var modelContext
  @Environment(AppState.self) private var appState
  @State var daysRemaining: Int = 365
  @State var resetDateButtonIsVisible: Bool = false
  @State var checkedDaysSet: Set<DateOnly> = Set()
  @Binding var isPresented: Bool

  var disablePreviousChevron: Bool {
    let selectedDate = appState.selectedDate
    return selectedDate.day == 1 && selectedDate.month == 1
  }
  var disableNextChevron: Bool {
    let selectedDate = appState.selectedDate
    return selectedDate.day == 31 && selectedDate.month == 12
  }
  var disableActionToggle: Bool {
    return
      (appState.selectedYear > appState.currentYear
      || (appState.selectedDate.dayOfYear() > appState.currentDate.dayOfYear()
        && appState
          .selectedYear == appState.currentYear))
  }

  var body: some View {

    let isChecked = ToggleBinding(
      habit: habit,
      modelContext: modelContext
    ).isChecked

    VStack(spacing: 10) {
      HStack(spacing: 16) {

        Button("Previous Day", systemImage: "chevron.left") {
          appState.selectedDate.toPreviousDay()
        }
        .buttonStyle(
          ChevronButton(
            buttonType: .large,
            buttonDir: .leading,
            isDisabled: disablePreviousChevron
          )
        )
        .disabled(disablePreviousChevron)

        Toggle(isOn: isChecked) {
          ToggleTextView(text: appState.formattedDateFromSelectedDate())
            .animation(.smooth(duration: 0.25), value: appState.selectedDate)
        }
        .toggleStyle(ActionToggleStyle(color: habit.color))
        .border(showBorder ? .purple : .clear)
        .disabled(disableActionToggle)

        Button("Next Day", systemImage: "chevron.right") {
          appState.selectedDate.toNextDay()
        }
        .buttonStyle(
          ChevronButton(
            buttonType: .large,
            buttonDir: .trailing,
            isDisabled: disableNextChevron
          )
        )
        .disabled(disableNextChevron)

      }
      // Padding between grid view and footer
      .padding(.top, 40)

      FooterStatsView(habit: habit, showBorder: showBorder)

      Button {
        appState.selectedDate = appState.currentDate
        appState.selectedYear = appState.currentYear
      } label: {
        Text("Reset to current date")
          .SGNormal()
          .fontWidth(.condensed)
          .foregroundStyle(ColorManager.toColorSecondary(color: habit.color))
      }
      .opacity(resetDateButtonIsVisible ? 1 : 0)
      .animation(.smooth, value: resetDateButtonIsVisible)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .contentShape(Rectangle())
    .border(showBorder ? .purple : .clear)
    .onAppear {
      createCheckedDaysSet()
      resetDateButtonIsVisible = (appState.selectedDate != appState.currentDate)
    }
    .onChange(of: appState.selectedDate) {
      resetDateButtonIsVisible = (appState.selectedDate != appState.currentDate)
    }
    .onChange(of: habit.checkedDays) {
      createCheckedDaysSet()
    }
    .gesture(
      DragGesture(minimumDistance: 24, coordinateSpace: .local).onChanged {
        value in
        let verticalAmount = value.translation.height
        if verticalAmount < 0 && !isPresented {
          isPresented = true
          Haptics.shared.play(.medium)
        }
      }
    )
  }

  func createCheckedDaysSet() {
    for checkedDay in habit.checkedDays {
      checkedDaysSet.insert(checkedDay.date)
    }
  }

}

#Preview {
  FooterView(
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
    showBorder: false,
    isPresented: .constant(true)
  )
  .environment(AppState.shared)
  .environment(UserStats.shared)
}
