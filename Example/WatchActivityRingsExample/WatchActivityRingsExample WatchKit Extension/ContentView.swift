import SwiftUI
import RingProgressView

struct ContentView2: View {
  @State var progress: CGFloat = 1
  @State var colors: [Color] = [.green, .orange]
  
  var body: some View {
    RingProgressGroupView(
      values: [progress],
      colors: [
        (Color(uiColor: UIColor(colors[0])), Color(uiColor: UIColor(colors[1])))
      ]
    )
      // .animation(.linear(duration: 5), value: progress)
      .onTapGesture {
        withAnimation(.ringProgressSpring) {
          progress = .random(in: 0..<2)
          // colors = colors.reversed()
        }
      }
  }
}

let colors = [
  (Color(uiColor: UIColor(.green)), Color(uiColor: UIColor(.red))),
  (Color(uiColor: UIColor(.mint)), Color(uiColor: UIColor(.brown))),
  (Color(uiColor: UIColor(.yellow)), Color(uiColor: UIColor(.pink))),
  (Color(uiColor: UIColor(.white)), Color(uiColor: UIColor(.blue))),
  (Color(uiColor: UIColor(.cyan)), Color(uiColor: UIColor(.indigo))),
  (Color(uiColor: UIColor(.teal)), Color(uiColor: UIColor(.purple))),
]

struct ContentView: View {
  @State var progresses: [CGFloat] = [0, 0, 0, 0, 0, 0]
  
  var body: some View {
    RingProgressGroupView(
      values: progresses,
      colors: colors,
      ringWidth: 8,
      ringSpacing: 1.5
    )
      .onTapGesture {
        withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 1)) {
          progresses = [
            .random(in: 0..<2),
            .random(in: 0..<2),
            .random(in: 0..<2),
            .random(in: 0..<2),
            .random(in: 0..<2),
            .random(in: 0..<2),
          ]
        }
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
