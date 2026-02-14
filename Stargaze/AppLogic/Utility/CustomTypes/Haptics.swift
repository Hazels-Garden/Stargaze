//
//  Haptics.swift
//  Stargaze
//
//  Created by Hazel Nishad on 6/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
// Source - https://stackoverflow.com/a/68088712
// Posted by rbaldwin, modified by community. See post 'Timeline' for change history
// Retrieved 2026-02-06, License - CC BY-SA 4.0

import UIKit

final class Haptics {
  static let shared = Haptics()
  
  private init() { }
  
  func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
  }
  
  func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
  }
}
