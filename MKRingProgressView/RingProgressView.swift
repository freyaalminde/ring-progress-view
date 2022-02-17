import SwiftUI

public struct RingProgressGroupView: View {
    var values: [CGFloat]
    var colors: [(Color, Color)]
    var ringWidth: CGFloat
    var ringSpacing: CGFloat
    
    public init(values: [CGFloat], colors: [(Color, Color)], ringWidth: CGFloat = 20, ringSpacing: CGFloat = 2) {
        self.values = values
        self.colors = colors
        self.ringWidth = ringWidth
        self.ringSpacing = ringSpacing
    }
    
    public var body: some View {
        ZStack {
            ForEach(Array(values.enumerated()), id: \.offset) { (index, value) in
                RingProgressView(
                    value: value,
                    startColor: colors[index].0,
                    endColor: colors[index].1,
                    ringWidth: ringWidth
                )
                    .padding((ringWidth + ringSpacing) * CGFloat(index))
            }
        }
    }
}

public struct RingProgressView: View {
    @State var layer = RingProgressLayer()
    var value: CGFloat
    var startColor: Color?
    var endColor: Color?
    var ringWidth: CGFloat

    public init(value: CGFloat, startColor: Color? = nil, endColor: Color? = nil, ringWidth: CGFloat = 20) {
        self.value = value
        self.startColor = startColor
        self.endColor = endColor
        self.ringWidth = ringWidth
    }
    
    public var body: some View {
        Canvas { context, size in
            context.withCGContext { cgContext in
                if let color = startColor?.cgColor { layer.startColor = color }
                if let color = endColor?.cgColor { layer.endColor = color }
                layer.ringWidth = ringWidth
                layer.progress = value
                layer.bounds = CGRect(origin: .zero, size: size)
                layer.drawContent(in: cgContext)
            }
        }
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
