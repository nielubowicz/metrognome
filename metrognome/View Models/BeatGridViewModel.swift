
struct BeatGridViewModel {
    @AppStorage("mostRecentBeats")
    var beats: [Beat] = []
    
    private let maximumRecentBeats = 4
    
    func addBeat(_ beat: Beat) {
        withAnimation {
            if beats.contains(beat) {
                beats.removeAll(where: {$0 == beat})
            }
            
            if beats.count >= maximumRecentBeats {
                beats.removeLast(beats.count + 1 - maximumRecentBeats)
            }
            
            beats.insert(beat, at: 0)
        }
    }
}