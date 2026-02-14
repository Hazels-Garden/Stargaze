//
//  GridTrackerView.swift
//  Stargaze
//
//  Created by Hazel Nishad on 23/1/26.
//  Copyright © 2026 Hazel's Garden. Check license for details.
// 💖✨
//

import SwiftUI

struct GridTrackerView: View {
  @State var viewModel: GridTrackerViewModel
  @Environment(AppState.self) private var appState

  let showBorder: Bool

  var body: some View {
    ZStack {
      GeometryReader { geom in
        let size = geom.size
        Canvas {
          context,
          size in
          // TODO: Make random stars "shine" periodically
          //            let now = timeline.date.timeIntervalSinceReferenceDatex
          //          let angle = now.remainder(dividingBy: 3) * 120

          for pointsData in viewModel.starPointsData {
            drawCanvas(
              context: context,
              size: size,
              starPoint: pointsData,
            )
          }
        }
        .onAppear {
          guard !viewModel.hasDataBeenSet else { return }
          viewModel.initializeCanvas()
          viewModel.initializeStars(size: size)
        }
        .onChange(of: geom.size) {
          viewModel.initializeStars(size: size)
        }
        .onChange(of: appState.selectedYear) {
          viewModel.initializeStars(size: size)
        }
        .onChange(of: viewModel.habit.checkedDays) {
          viewModel.initializeCanvas()
          viewModel.reinitializeStars(size: size)
        }
        .border(showBorder ? Color(.tertiaryLabel) : .clear)
        .gesture(
          DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged { value in
              handleDragGesture(value: value)
            }
            .onEnded { value in
              viewModel.handleDragGestureEnd(value: value)
            }
        )
      }
      
      // Disables the grid indic. from moving when tapping year chevrons
      VStack(spacing: 0) {
        Spacer()
        Rectangle()
          .fill(.clear)
          .frame(maxHeight: 8)
          .contentShape(Rectangle())
          .onTapGesture {}
      }

      // Debug border rectangle
      Rectangle()
        .foregroundStyle(.clear)
        .border(showBorder ? Color(.tertiaryLabel) : .clear)
        .frame(
          maxWidth: .infinity,
          minHeight: viewModel.canvasHeight,
          maxHeight: viewModel.canvasHeight,
        )
        .padding(.horizontal, viewModel.horizontalPadding)
    }
    .frame(
      maxWidth: .infinity,
      maxHeight: viewModel.canvasHeight + (2 * viewModel.verticalPadding)
    )
  }

  // *************** Struct Methods Below ******************

  func handleDragGesture(value: DragGesture.Value) {
    let closestStarPoint = viewModel.handleDragGesture(value: value)

    if closestStarPoint.point != viewModel.tappedStarPoint {
      viewModel.tappedStarPoint = closestStarPoint.point
      Haptics.shared.play(.rigid)
    }
  }

  func moveCanvasToStar(
    context: inout GraphicsContext,
    for starPoint: (
      cgPoint: CGPoint, intPoint: Point, angle: Double, isChecked: Bool
    ),
  ) {
    // Moving them into place (-half starSize because we want topleft)
    context.translateBy(
      x: starPoint.cgPoint.x - (viewModel.starSize / 2),
      y: starPoint.cgPoint.y - (viewModel.starSize / 2)
    )
  }

  func rotateStarByAngle(
    context: inout GraphicsContext,
    for starPoint: (
      cgPoint: CGPoint, intPoint: Point, angle: Double, isChecked: Bool
    ),
  ) {
    // Moving the pivot to the center before rotating them
    context.translateBy(
      x: (viewModel.starSize / 2),
      y: (viewModel.starSize / 2)
    )
    context.rotate(by: .degrees(starPoint.angle))
    context.translateBy(
      x: -(viewModel.starSize / 2),
      y: -(viewModel.starSize / 2)
    )
  }

  func drawDateIndictator(
    for date: DateOnly,
    color: Color,
    context: GraphicsContext,
    size: CGSize,
    using starPoint: (
      cgPoint: CGPoint, intPoint: Point, angle: Double, isChecked: Bool
    ),
  ) {
    let indicatorContext = context

    // Move the currentDate pointer to 1 if selYear != curYear
    // I set the selDate itself to 1 for that condition so this is not req
    if date == appState.currentDate
      && appState.selectedYear != appState.currentYear
    {
      guard
        viewModel.getStarNum(from: starPoint.intPoint) == 1
      else { return }
    } else {
      guard
        viewModel.getStarNum(from: starPoint.intPoint) == date.dayOfYear()
      else { return }
    }
    indicatorContext
      .stroke(
        RoundedRectangle(cornerRadius: 4)
          .path(
            in: CGRect(
              x: -(viewModel.starSize / 2),
              y: -(viewModel.starSize / 2),
              width: 16,
              height: 16
            )
          ),
        with: .color(color),
        lineWidth: 2
      )
  }

  // ************ The main DRAW function is here! ****************

  func drawCanvas(
    context: GraphicsContext,
    size: CGSize,
    starPoint: (
      cgPoint: CGPoint, intPoint: Point, angle: Double, isChecked: Bool
    ),
  ) {
    var starContext = context

    var star = context.resolve(Image("Star"))
    star.shading = .color(
      Color(.quaternaryLabel).mixed(
        with: ColorManager.toColorPrimary(color: viewModel.habit.color),
        by: 0.1
      )
    )

    // Old method: highlighted when star is tapped
    //    if let tappedStarPoint = viewModel.tappedStarPoint {
    //      if Point(r: starPoint.intPoint.r, c: starPoint.intPoint.c)
    //        == tappedStarPoint
    //      {
    //        star.shading = .color(
    //          ColorMananger.toColorSecondary(color: viewModel.habit.color)
    //        )
    //      }
    //    }

    let currentStarNum = viewModel.getStarNum(from: starPoint.intPoint)

    if currentStarNum == appState.selectedDate.dayOfYear()
      && currentStarNum != appState.currentDate.dayOfYear()
    {
      star.shading = .color(
        ColorManager.toColorSecondary(
          color: viewModel.habit.color,
          opacity: 0.8
        )
      )
    }

    if starPoint.isChecked {
      star.shading =
        .color(
          ColorManager.toColorPrimary(color: viewModel.habit.color)
        )
    }

    moveCanvasToStar(context: &starContext, for: starPoint)

    drawDateIndictator(
      for: appState.currentDate,
      color: ColorManager.toColorSecondary(
        color: viewModel.habit.color,
        opacity: 0.75
      ),
      context: starContext,
      size: size,
      using: starPoint
    )
    drawDateIndictator(
      for: appState.selectedDate,
      color: ColorManager.toColorPrimary(
        color: viewModel.habit.color,
      ),
      context: starContext,
      size: size,
      using: starPoint
    )

    // Irreversible rotation by below function!
    rotateStarByAngle(context: &starContext, for: starPoint)

    starContext.draw(star, in: viewModel.frame)
  }
}

#Preview {
  GridTrackerView(
    viewModel: GridTrackerViewModel(
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
      horizontalPadding: 24,
      verticalPadding: 16,
      canvasHeight: 420,
    ),
    showBorder: true
  )
  .environment(AppState.shared)
  .environment(UserStats.shared)
}
