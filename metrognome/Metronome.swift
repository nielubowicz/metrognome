import AVKit

class Metronome: ObservableObject {
    var beat: Beat
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var beatCount = 1
    
    private struct Internal {
        static var cache = [URL:SystemSoundID]()
    }
    
    init(beat: Beat) {
        self.beat = beat
        
        // Set up system sounds
        var soundID : SystemSoundID = Internal.cache[tickURL] ?? 0
        if soundID == 0 {
            let status = AudioServicesCreateSystemSoundID(tickURL as CFURL, &soundID)
            if status == kAudioServicesNoError {
                Internal.cache[tickURL] = soundID
            } else {
                print("Error loading sound: \(status)")
            }
        }
        
        soundID = Internal.cache[tockURL] ?? 0
        if soundID == 0 {
            let status = AudioServicesCreateSystemSoundID(tockURL as CFURL, &soundID)
            if status == kAudioServicesNoError {
                Internal.cache[tockURL] = soundID
            } else {
                print("Error loading sound: \(status)")
            }
        }
    }
        
    private var tickTimer: Timer?
    
    func play() {
        isPlaying = true
        let timer = Timer(
            timeInterval: 60.0 / Double(beat.bpm),
            repeats: true
        ) { _ in
            guard let tickSoundID = Internal.cache[self.tickURL],
                  let tockSoundID = Internal.cache[self.tockURL] else { return }
            
            let sound = self.beatCount == 1 ? tockSoundID : tickSoundID
            AudioServicesPlaySystemSoundWithCompletion(sound, nil)
            self.beatCount = (self.beatCount % self.beat.tempo.numerator) + 1
        }
        self.tickTimer = timer
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func pause() {
        tickTimer?.invalidate()
        tickTimer = nil
        isPlaying = false
        beatCount = 1
    }
    
    private var tickURL: URL {
        Bundle.main.url(forResource: "tick", withExtension: "aiff")!
    }
    
    private var tockURL: URL {
        Bundle.main.url(forResource: "tock", withExtension: "aiff")!
    }
}
