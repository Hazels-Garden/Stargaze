//
//  HabitTabView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 17/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI
import SwiftData

struct HabitTabView: View {
  
  @Query(sort: \Habit.sortOrder) var habits: [Habit]
  @Environment(\.modelContext) var modelContext
  
    var body: some View {
      return TabView() {
        ForEach(habits) {habit in
          HabitView(habit: habit)
        }
      }
      .ignoresSafeArea()
      .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
  HabitTabView()
    .modelContainer(SampleData.shared.modelContainer)
    .environment(AppState.shared)
}
