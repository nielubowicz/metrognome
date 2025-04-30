import SwiftUI

struct MetronomeView: View {
    @ObservedObject var metronome: Metronome
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1..<1 + metronome.beat.tempo.numerator, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(index == metronome.beatCount ? .blue : .gray)
                }
            }
            .frame(maxHeight: 120)
            Button("", systemImage: metronome.isPlaying ? "stop.circle" : "play.circle") {
                if metronome.isPlaying {
                    metronome.pause()
                } else {
                    metronome.play()
                }
            }
        }
    }
}
