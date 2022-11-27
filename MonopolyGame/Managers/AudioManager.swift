import AVFoundation

var player: AVAudioPlayer?

 
func playSound(soundName:String,repat:Int = 0) {


    guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
        
        return
    }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)

              player = try AVAudioPlayer(contentsOf: url)

            player?.numberOfLoops = repat
            player!.play()

        } catch let error {
            print(error.localizedDescription)
        }
}

func playMove() {
    if(playMoveSound) {
        playSound(soundName: "move")
    }
}

 
