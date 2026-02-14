//
//  Detent.swift
//  Stargaze
//
//  Created by Hazel Nishad on 12/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import Foundation
import SwiftUI

struct Detent {
  
  static var peekHeight: CGFloat = 180
  
  static var peekDetent: PresentationDetent {
    .height(Detent.peekHeight)
  }
  
  static var fullDetent: PresentationDetent {
    .fraction(0.9)
  }
  
  enum DetentEnum: Double {
    case peek
    case full
  }

  static func getDetent(detent: DetentEnum) -> PresentationDetent {
    switch detent {
    case .peek: Self.peekDetent
    case .full: Self.fullDetent
    }
  }
}
