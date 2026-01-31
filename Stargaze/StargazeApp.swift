//
//  StargazeApp.swift
//  Stargaze
//
//  Created by Hazel Nishad on 10/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftData
import SwiftUI

@main
struct StargazeApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    //        .modelContainer(for: Habit.self)
    // TODO: Change this back!!
    .modelContainer(SampleData.shared.modelContainer)
  }
}
