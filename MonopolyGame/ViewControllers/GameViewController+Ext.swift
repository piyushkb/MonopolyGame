 

import UIKit
 

extension GameViewController  {

    
    public func animateDiceImageView(_ diceImageView: UIImageView, diceFace dice: Int) {
        var randomMidX: CGFloat {
            DiceAnimationView.frame.midX + CGFloat.random(in: -50...50)
        }
        var minY: CGFloat {
            diceImageView.frame.height * 0.8 // to be always in the bounds (0.75 of a dice height + a bit extra)
        }
        
        removeBehaviours(from: diceImageView)
        
        // Fadeout and reappear at the top of the view
        UIViewPropertyAnimator.runningPropertyAnimator(
            // Make the previous dice disappear
            withDuration: 0.2,
            delay: 0.0,
            options: .curveEaseInOut,
            animations: { diceImageView.alpha = 0.0 }
        ) { _ in
            // Move to the top of the view, add acceleration, appear
            diceImageView.center = CGPoint(x: randomMidX, y: minY)
            diceImageView.image = Const.DiceFaces[dice - 1]
            diceImageView.alpha = 1.0
            self.DiceAnimationView.layoutIfNeeded()
            self.addBehaviours(to: diceImageView)
            self.bouncingBehavior.addAngularVelocity(CGFloat.random(in: -20...20), for: diceImageView)
        }
    }
    
    // Remove animation behaviours
    public func removeBehaviours(from diceImageView: UIImageView) {
        collisionBehavior.removeItem(diceImageView)
        bouncingBehavior.removeItem(diceImageView)
        gravityBehavior.removeItem(diceImageView)
    }
    
    // Add animation behaviours
    public func addBehaviours(to diceImageView: UIImageView) {
        self.collisionBehavior.addItem(diceImageView)
        self.bouncingBehavior.addItem(diceImageView)
        self.gravityBehavior.addItem(diceImageView)
    }

    
    public func configDiceImageView( _ diceImageView: inout UIImageView!) {
        
        if(isiPad()) {
            Const.DiceSize = 100
        }else {
            Const.DiceSize = 50
        }
       
        diceImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Const.DiceSize, height: Const.DiceSize))
        diceImageView.contentMode = .scaleAspectFill
        diceImageView.alpha = 0.0
        
        diceImageView.layer.cornerRadius = 8
        diceImageView.layer.borderColor = .init(gray: 0.5, alpha: 0.3)
        diceImageView.layer.borderWidth = 1
        diceImageView.layer.masksToBounds = true
    }
    
    func configAnimation() {
        dynamicAnimator = UIDynamicAnimator(referenceView: DiceAnimationView)
        
        gravityBehavior = UIGravityBehavior()
        gravityBehavior.magnitude = 1.4
        dynamicAnimator.addBehavior(gravityBehavior)
        
        collisionBehavior = UICollisionBehavior()
        collisionBehavior.collisionDelegate = self
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        
        bouncingBehavior = UIDynamicItemBehavior()
        bouncingBehavior.elasticity = 0.6
        bouncingBehavior.density = 0.9
        bouncingBehavior.friction = 0.4
        dynamicAnimator.addBehavior(bouncingBehavior)
    }
    
}



extension GameViewController: UICollisionBehaviorDelegate {
    // Play sound and haptic feedback for dice collisions animation
    func collisionBehavior(
        _ behavior: UICollisionBehavior,
        beganContactFor item: UIDynamicItem,
        withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint
    ) {
        
        // Play vibration
        if Const.DefaultIsVibrationEnabled {
           // SoundAndHapticController.playHaptic()
        }
        // Play sound
        if Const.DefaultIsSoundEnabled {
            SoundAndHapticController.playRandomCachedSound()
        }
    }
                
}


extension GameViewController {
    
    public func updateUI() {
        //let player = game.activePlayer
        //disable clik till action
         
    }
    
    public func startNewGame() {
//        dice1ImageView.alpha = 0.0
//        dice2ImageView.alpha = 0.0
//
//        removeBehaviours(from: dice1ImageView)
//        removeBehaviours(from: dice2ImageView)
//
//        dice1ImageView.removeFromSuperview()
//        dice2ImageView.removeFromSuperview()
//
//        updateUI()
        
    }
}
