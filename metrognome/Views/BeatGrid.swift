import SwiftUI

struct BeatGrid: View {
    let viewModel: BeatGridViewModel
    let tapAction: (Beat) -> Void
        
    var body: some View {
        Grid {
            GridRow(alignment: .firstTextBaseline) {
                ForEach(viewModel.beats) { beat in
                    VStack {
                        Text(L10n.bpm(beat.bpm))
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
                    .contentShape(RoundedRectangle(cornerRadius: 16, style: .circular))
                    .onTapGesture {
                        withAnimation {
                            tapAction(beat)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let beat1 = Beat(bpm: 100, tempo: Tempo(numerator: 3, denominator: 4))
    let beat2 = Beat(bpm: 200, tempo: Tempo(numerator: 3, denominator: 4))
    let beat3 = Beat(bpm: 300, tempo: Tempo(numerator: 3, denominator: 4))
    let beat4 = Beat(bpm: 400, tempo: Tempo(numerator: 3, denominator: 4))
    
    let beats = [ beat1, beat2, beat3, beat4 ]
    let viewModel = BeatGridViewModel(beats: beats)
    BeatGrid(viewModel: viewModel) {
        beat in viewModel.addBeat(beat)
    }
}
