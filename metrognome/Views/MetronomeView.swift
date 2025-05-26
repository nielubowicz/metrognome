import SwiftUI

struct MetronomeView: View {
    @ObservedObject var metronome: Metronome
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1..<1 + metronome.beat.tempo.numerator, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(index == metronome.beatCount ? .blue : .gray)
                        .scaleEffect(index == metronome.beatCount ? 1.1 : 1)
                        .animation(.bouncy, value: metronome.beatCount)
                        .onTapGesture {
                            if metronome.isPlaying {
                                metronome.pause()
                                metronome.beatCount = index
                                metronome.play()
                            } else {
                                metronome.beatCount = index
                            }
                        }
                }
            }
            .frame(maxHeight: 120)
            Button {
                if metronome.isPlaying {
                    metronome.pause()
                } else {
                    metronome.play()
                }
            } label: {
                Label("", systemImage: metronome.isPlaying ? "stop.circle" : "play.circle")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .padding(48)
        }
    }
}
