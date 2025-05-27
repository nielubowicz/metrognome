import SwiftUI

struct BeatGrid: View {
    let beats: [Beat]
    let tapAction: () -> Void
    
    var body: some View {
        Grid {
            GridRow(alignment: .firstTextBaseline) {
                ForEach(beats) { beat in
                    VStack {
                        Text("\(beat.bpm) bpm")
                            .font(.caption)
                            .fontWeight(.bold)
                        Text("\(beat.tempo.numerator) / \(beat.tempo.denominator)")
                            .font(.caption)
                    }
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .stroke(UIColor.separator.color, lineWidth: 1)
                    }
                    .onTapGesture {
                        withAnimation {
                            tapAction()
                        }
                    }
                }
            }
        }
    }
}
