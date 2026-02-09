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
        TimelineView(.animation) { timeline in
          Canvas {
            context,
            size in

            // TODO: Make random stars "shine" periodically
            //          let now = timeline.date.timeIntervalSinceReferenceDate
            //          let angle = now.remainder(dividingBy: 3) * 120

            for pointsData in viewModel.starPointsData {
              drawStarGrid(
                context: context,
                size: size,
                starPoint: pointsData,
              )
            }

          }
          .onAppear {
            guard !viewModel.hasDataBeenSet else { return }
            let size = geom.size
            initializeCanvas()
            initalizeStars(size: size)
          }
          .onChange(of: geom.size) {
            let size = geom.size
            initalizeStars(size: size)
          }
          .border(showBorder ? Color(.tertiaryLabel) : .clear)
          .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
              .onChanged { value in
                handleDragGesture(value: value)
              }
              .onEnded { value in
                viewModel.tappedStarPoint = nil
              }
          )
        }
      }

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

  // *************** Struct Functions Below ******************

  func initializeCanvas() {
    viewModel.hasDataBeenSet = true
    viewModel.getCheckedDaysSet()
  }

  func initalizeStars(size: CGSize) {
    viewModel.initializeStars(size: size)
  }

  func handleDragGesture(
    value: DragGesture.Value,
  ) {
    let closestStarPoint = viewModel.handleDragGesture(value: value)

    if closestStarPoint.point != viewModel.tappedStarPoint {

      // You have to be close to a star to interact
      // Squared because the euclidean dist isn't sqrt'd
      let interactRadius = 16.0
      guard closestStarPoint.dist < pow(interactRadius, 2) else {
        return
      }

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

  // ************ The DRAW function is here! ****************

  func drawStarGrid(
    context: GraphicsContext,
    size: CGSize,
    starPoint: (
      cgPoint: CGPoint, intPoint: Point, angle: Double, isChecked: Bool
    ),
  ) {

    var star = context.resolve(Image("Star"))
    star.shading =
      starPoint.isChecked
      ? .color(
        ColorMananger.toColorPrimary(color: viewModel.color)
      )
      : .color(
        Color(.quaternaryLabel).mix(
          with: ColorMananger.toColorPrimary(color: viewModel.color),
          by: 0.1
        )
      )

    if let tappedStarPoint = viewModel.tappedStarPoint {
      if Point(r: starPoint.intPoint.r, c: starPoint.intPoint.c)
        == tappedStarPoint
      {
        star.shading = .color(
          ColorMananger.toColorSecondary(color: viewModel.color)
        )
      }
    }

    var starContext = context
    moveCanvasToStar(context: &starContext, for: starPoint)
    rotateStarByAngle(context: &starContext, for: starPoint)
    starContext.draw(star, in: viewModel.frame)

    //    starContext.stroke(Rectangle().path(in: frame), with: .foreground)
  }
}

#Preview {
  GridTrackerView(
    viewModel: GridTrackerViewModel(
      color: ["hue": 1, "sat": 0, "bri": 1, "opa": 1],
      checkedDays: [
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_208_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_640_000)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_736_899_200)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_244_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_417_600)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_676_800)),
        CheckedDays(date: Date(timeIntervalSince1970: 1_737_936_000)),
      ],
      horizontalPadding: 24,
      verticalPadding: 16,
      canvasHeight: 420,
    ),
    showBorder: true
  )
  .environment(AppState.shared)
}
