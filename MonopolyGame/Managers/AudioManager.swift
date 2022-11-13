import AVFoundation

var player: AVAudioPlayer?

 
func playSound(soundName:String) {


    guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
        
        return
    }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)

              player = try AVAudioPlayer(contentsOf: url)

            player!.play()

        } catch let error {
            print(error.localizedDescription)
        }
}

func playMove() {
    playSound(soundName: "move")
}

 