//
//  SampleData.swift
//  Stargaze
//
//  Created by Hazel Nishad on 19/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import SwiftData

@MainActor
final class SampleData {
  
  static let shared = SampleData()
  
  let modelContainer: ModelContainer
  
  var context: ModelContext {
    modelContainer.mainContext
  }
  
  private init() {
    let schema = Schema([Habit.self])
    let modelConfiguration = ModelConfiguration(
      schema: schema,
      isStoredInMemoryOnly: true
    )
    do {
      modelContainer = try ModelContainer(
        for: schema,
        configurations: [modelConfiguration]
      )
      insertSampleData()
      try context.save()
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }
  
  private func insertSampleData() {
    for habit in Habit.sampleData {
      context.insert(habit)
    }
  }
  
}
