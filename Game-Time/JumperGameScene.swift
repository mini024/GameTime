//
//  GameScene.swift
//  Jumper
//
//  Created by Luis Alfonso Arriaga Quezada on 3/21/15.
//  Copyright (c) 2015 Luis Alfonso Arriaga Quezada. All rights reserved.
//

import SpriteKit
import AVFoundation


class JumperGameScene: SKScene, SKPhysicsContactDelegate
{
    var viewController: UIViewController?
    var Canguro = SKSpriteNode()
    var texture = SKTexture(imageNamed:"Canguro1")
    var spritetexture = SKTexture(imageNamed:"Canguro2")
    var Coco = SKSpriteNode()
    var Coco2 = SKSpriteNode()
    var cocoTexture = SKTexture(imageNamed: "coco")
    var Hits = 0
    var labelHits = SKLabelNode(fontNamed: "Helvetica")
    var labelTimesHit = SKLabelNode(fontNamed:"Helvetica")
    var labelTimer = SKLabelNode(fontNamed: "Helvetica")
    var labelTime = SKLabelNode(fontNamed: "Helvetica")
    var Time = 30
    var gameTimer = NSTimer()
    var BkPlayer = AVAudioPlayer()
    var bkSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Pink_Lemonade", ofType: "mp3")!)
    
    func playMySound(){
        BkPlayer = AVAudioPlayer(contentsOfURL: bkSound, error: nil)
        BkPlayer.prepareToPlay()
        BkPlayer.play()
    }
    

    override func didMoveToView(view: SKView) {
        
        var bgImage = SKSpriteNode(imageNamed: "fondo_jumper.jpg")
        bgImage.xScale = self.frame.size.width * 0.0004
        bgImage.yScale = self.frame.size.height * 0.00052
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        self.addChild(bgImage)
        
        self.Canguro = SKSpriteNode(texture: texture)
        self.Canguro.xScale = self.frame.size.width * 0.00020
        self.Canguro.yScale = self.frame.size.height * 0.00025
        self.Canguro.position = CGPointMake(self.frame.size.width/2, 310);

        
        self.addChild(self.Canguro)
        
        self.Canguro.physicsBody = SKPhysicsBody(rectangleOfSize: Canguro.size) // 1
        self.Canguro.physicsBody?.dynamic = false // 2
        
        
        //PlayMusic
        playMySound()
        
        // TERMINA Agregar el canguro a la scene
        
        labelTimesHit.text = "Times hit:"
        labelTimesHit.fontSize = 30
        labelTimesHit.position = CGPoint(x:CGRectGetMidX(self.frame)+80,y:700)
        self.addChild(labelTimesHit)
        
        Hits = 0
        labelHits.text = String (Hits)
        labelHits.fontSize = 30
        labelHits.position = CGPoint(x:CGRectGetMidX(self.frame)+170,y:700)
        self.addChild(labelHits)
        
        labelTimer.text = "Time:"
        labelTimer.fontSize = 30
        labelTimer.position = CGPoint(x:CGRectGetMidX(self.frame)-130,y:700)
        self.addChild(labelTimer)
        
        labelTime.text = String(Time)
        labelTime.fontSize = 30
        labelTime.position = CGPoint(x:CGRectGetMidX(self.frame)-66,y:700)
        self.addChild(labelTime)
        
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("gameLimit"), userInfo: nil, repeats: true)

        
    }
    
    func gameLimit () {
        Time--
        labelTime.text = String(Time)
        if ( Time == 0){
            returnToMainMenu()
        }
    }
    
    func returnToMainMenu(){
        BkPlayer.stop()
        var vc: UIViewController = UIViewController()
        self.viewController?.performSegueWithIdentifier("Menu", sender: vc)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        //Animacion
        var animationtouch = SKAction.animateWithTextures([texture, spritetexture, texture], timePerFrame: 0.1)
        self.Canguro.runAction(animationtouch)
        var wait = SKAction.waitForDuration(0.1)
        var run = SKAction.runBlock({
            self.Hits++
            self.labelHits.text = String(self.Hits)
        })
        self.runAction(SKAction.sequence([wait,run]))
        
   
    
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
