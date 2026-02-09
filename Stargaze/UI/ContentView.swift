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

// TODO: add the only dark mode and portrait mode constraints

struct ContentView: View {

  @Environment(\.modelContext) var modelContext
  var appState = AppState.shared

  var body: some View {
    ZStack {
      HabitTabView(selection: 0)
    }
    .ignoresSafeArea()
    .environment(appState)
  }
}

#Preview {
  ContentView()
    .modelContainer(SampleData.shared.modelContainer)
}
