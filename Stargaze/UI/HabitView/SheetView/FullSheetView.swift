//
//  FullSheetView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 12/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct FullSheetView: View {
    var body: some View {
      VStack() {
        Text("Observation Deck")
          .SGTitle()
          .fontWidth(.expanded)
          .padding(.bottom, 36)
        
        VStack(spacing: 4) {
          Text("Stargaze")
            .SGLarge()
            .fontWidth(.condensed)
            .foregroundStyle(.primary)
          Button {
            
          } label: {
            Text("Buy Stargaze")
              .SGNormal()
              .fontWidth(.expanded)
          }
          .buttonStyle(TextButtonStyle())
          Button {
            
          } label: {
            Text("Settings")
              .SGNormal()
              .fontWidth(.expanded)
          }
          .buttonStyle(TextButtonStyle())
        }
        .padding(.bottom, 36)
        
        VStack(spacing: 4) {
          Text("Create New")
            .SGLarge()
            .fontWidth(.condensed)
            .foregroundStyle(.primary)
          Button {
            
          } label: {
            Text("New Constellation")
              .SGNormal()
              .fontWidth(.expanded)
          }
          .buttonStyle(TextButtonStyle())
        }
        .padding(.bottom, 36)
        
        VStack(spacing: 4) {
          HStack {
            Text("Manage Constellations")
              .SGLarge()
              .fontWidth(.condensed)
              .foregroundStyle(.primary)
            Text("(Jump to page by tapping)")
              .SGNormal()
              .fontWidth(.condensed)
              .foregroundStyle(.secondary)
          }
          Button {
            
          } label: {
            Text("New Constellation")
              .SGNormal()
              .fontWidth(.expanded)
          }
          .buttonStyle(TextButtonStyle())
        }
      }
      .border(.yellow)
    }
}

#Preview {
    FullSheetView()
}
