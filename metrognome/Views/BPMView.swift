import SwiftUI

struct BPMView: View {
    @Binding var bpm: Int
    @State private var timer: Timer?
    
    var body: some View {
        HStack {
            Button {
                bpm = bpm - 1
            } label: {
                Label("", systemImage: "minus.circle")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .contentShape(Rectangle())
            .padding(.horizontal)
            
            Spacer(minLength: 4)
            Text(bpm.formatted())
            Spacer(minLength: 4)
            
            Button {
                bpm = bpm + 1
            } label: {
                Label("", systemImage: "plus.circle")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .padding(.horizontal)
        }
    }
    
    private func startIncreasingTempo() {
        stopChangingTempo()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            bpm += 1
        }
    }
    
    private func startDecreasingTempo() {
        stopChangingTempo()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            bpm -= 1
        }
    }
    
    private func stopChangingTempo() {
        timer?.invalidate()
        timer = nil
    }
}
