import SwiftUI

public struct RingProgressGroupView: View {
  @State var hasAppeared = false
  var values: [CGFloat]
  var colors: [(Color, Color)]
  var ringWidth: CGFloat
  var ringSpacing: CGFloat
  var hidesRingForZeroProgress: Bool
  var appearAnimationDelay: Double
  
  public init(
    values: [CGFloat],
    colors: [(Color, Color)],
    ringWidth: CGFloat = 36,
    ringSpacing: CGFloat = 1.5,
    hidesRingForZeroProgress: Bool = false,
    appearAnimationDelay: Double = 0.3
  ) {
    self.values = values
    self.colors = colors
    self.ringWidth = ringWidth
    self.ringSpacing = ringSpacing
    self.hidesRingForZeroProgress = hidesRingForZeroProgress
    self.appearAnimationDelay = appearAnimationDelay
  }
  
  public var body: some View {
    ZStack {
      ForEach(Array(values.enumerated()), id: \.offset) { (index, value) in
        RingProgressView(
          value: hasAppeared ? value : 0,
          startColor: colors[index].0,
          endColor: colors[index].1,
          ringWidth: ringWidth,
          hidesRingForZeroProgress: hidesRingForZeroProgress
        )
          .padding((ringWidth + ringSpacing) * CGFloat(index))
      }
    }
    .onAppear {
      if appearAnimationDelay > 0 {
        DispatchQueue.main.asyncAfter(deadline: .now() + appearAnimationDelay) {
          withAnimation(.ringProgressSpring) { self.hasAppeared = true }
        }
      } else {
        hasAppeared = true
      }
    }
  }
}

public extension Animation {
  static let ringProgressSpring = spring(response: 1, dampingFraction: 1, blendDuration: 1)
}

public struct RingProgressView: View {
  @State var layer = RingProgressLayer()
  var value: CGFloat
  var startColor: Color?
  var endColor: Color?
  var ringWidth: CGFloat
  var hidesRingForZeroProgress: Bool

  public init(
    value: CGFloat,
    startColor: Color? = nil,
    endColor: Color? = nil,
    ringWidth: CGFloat = 36,
    hidesRingForZeroProgress: Bool = false
  ) {
    self.value = value
    self.startColor = startColor
    self.endColor = endColor
    self.ringWidth = ringWidth
    self.hidesRingForZeroProgress = hidesRingForZeroProgress
  }
  
  public var body: some View {
    Canvas { context, size in
      context.withCGContext { cgContext in
        layer.bounds = CGRect(origin: .zero, size: size)
        layer.progress = value
        if let color = startColor?.cgColor {
          layer.startColor = color
        }
        if let color = endColor?.cgColor {
          layer.endColor = color
        }
        layer.ringWidth = ringWidth
        layer.hidesRingForZeroProgress = hidesRingForZeroProgress
        layer.drawContent(in: cgContext)
      }
    }
    .accessibilityValue(String(format: "%.f%%", value * 100))
    .accessibilityAddTraits(.updatesFrequently)
  }
}

extension RingProgressView: Animatable {
  public var animatableData: CGFloat {
    get { value }
    set { value = newValue }
  }
}

struct RingProgressView2_Previews: PreviewProvider {
  static var previews: some View {
    RingProgressView(value: 0.5)
  }
}
