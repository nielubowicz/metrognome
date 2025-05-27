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

    @AppStorage("mostRecentBeats")
    private var mostRecentBeats: [Beat] = []
    
    init(beat: Beat = Beat(bpm: 100, tempo: Tempo(numerator: 3, denominator: 4))) {
        _beat = State(initialValue: beat)
        _metronome = StateObject(wrappedValue: Metronome(beat: beat))
    }
    
    var body: some View {
        VStack {
            Spacer()
            BPMView(bpm: $beat.bpm.nonNegative)
                .padding(.bottom, 48)
            TempoView(tempo: $beat.tempo)
            Spacer()
            MetronomeView(metronome: metronome)
            Spacer()
            BeatGrid(beats: mostRecentBeats) {
                self.beat = beat
                metronome.beat = beat
            }
        }
        .padding()
        .onChange(of: beat) { _, newValue in
            metronome.beat = newValue
        }
        .onChange(of: metronome.isPlaying) { _, newValue in
            guard newValue else { return } // don't do anything if metronome isn't playing
            if mostRecentBeats.contains(beat) {
                mostRecentBeats.removeAll(where: {$0 == beat})
            }
            
            mostRecentBeats.insert(beat, at: 0)
        }
    }
}

#Preview {
    ContentView()
}
