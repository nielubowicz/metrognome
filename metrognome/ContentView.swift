//
//  ContentView.swift
//  metrognome
//
//  Created by mac on 4/30/25.
//

import SwiftUI

struct ContentView: View {
    @State private var beat: Beat
    @StateObject private var metronome: Metronome

    init(beat: Beat = Beat(bpm: 100, tempo: Tempo(numerator: 3, denominator: 4))) {
        _beat = State(initialValue: beat)
        _metronome = StateObject(wrappedValue: Metronome(beat: beat))
    }
    
    var body: some View {
        VStack {
            Spacer()
            BPMView(bpm: $beat.bpm)
                .padding(.bottom, 48)
            TempoView(tempo: $beat.tempo)
            Spacer()
            MetronomeView(metronome: metronome)
            Spacer()
        }
        .padding()
        .onChange(of: beat) { _, newValue in
            let wasPlaying = metronome.isPlaying
            metronome.pause()
            metronome.beat = newValue
            if wasPlaying {
                metronome.play()
            }
        }
    }
}

#Preview {
    ContentView()
}
