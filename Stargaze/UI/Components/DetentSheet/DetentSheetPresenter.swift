//
//  DetentSheetPresenter.swift
//  Stargaze
//
//  Created by Hazel Nishad on 11/2/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct DetentSheetPresenter<SheetContent: View>: ViewModifier {

  @Binding var isPresented: Bool
  @ViewBuilder let sheetContent: (Binding<Detent.DetentEnum>) -> SheetContent

  @Binding var selectedDetentEnum: Detent.DetentEnum
  @State private var sheetInteraction: PresentationContentInteraction = .resizes

  func body(content: Content) -> some View {

    let selectedDetent: Binding<PresentationDetent> = Binding(
      get: {
        Detent.getDetent(detent: selectedDetentEnum)
      },
      set: { value in
        selectedDetentEnum = value == Detent.peekDetent ? .peek : .full
      }
    )

    let sheetContentBase =
      ScrollView {
        sheetContent($selectedDetentEnum)
      }
      .presentationDetents(
        [Detent.peekDetent, Detent.fullDetent],
        selection: selectedDetent
      )
      .presentationContentInteraction(sheetInteraction)
      .presentationDragIndicator(.hidden)
      .ignoresSafeArea()

    content
      .sheet(isPresented: $isPresented) {
        if #available(iOS 26.0, *) {
          sheetContentBase
        } else {
          sheetContentBase
            .presentationCornerRadius(40)
            .presentationBackground(.ultraThinMaterial)
        }
      }
      .onChange(of: selectedDetent.wrappedValue) { _, newValue in
        sheetInteraction = newValue == Detent.peekDetent ? .resizes : .scrolls
      }
  }
}
