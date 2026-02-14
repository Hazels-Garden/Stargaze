//
//  ContentView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 10/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftData
import SwiftUI

struct ContentView: View {

  @Environment(\.modelContext) var modelContext
  var appState = AppState.shared
  var userStats = UserStats.shared

  var body: some View {
    ZStack {
      HabitTabView()
    }
    .ignoresSafeArea()
    .environment(appState)
    .environment(userStats)
  }
}

#Preview {
  ContentView()
    .modelContainer(SampleData.shared.modelContainer)
}
