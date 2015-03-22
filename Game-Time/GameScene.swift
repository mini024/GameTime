//
//  GameScene.swift
//  Game-Time
//
//  Created by Jessica Cavazos on 3/21/15.
//  Copyright (c) 2015 TimeTeam. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate  {
    
    var viewController: UIViewController?
    var mono = SKSpriteNode()
    var canasta = SKSpriteNode()
    var bananas = 0
    var banana = SKSpriteNode()
    var bananascachadas = 0
    var labelTime = SKLabelNode(fontNamed: "Helvetica")
    let KeyName = "music2"
    var bkSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Saddest_Beach", ofType: "mp3")!)
    var BkPlayer = AVAudioPlayer()
    
    func playMySound(){
        BkPlayer = AVAudioPlayer(contentsOfURL: bkSound, error: nil)
        BkPlayer.prepareToPlay()
        BkPlayer.play()
    }
    

    func bananacai(){
        for var i=0; i<1; i++ {
            var wait = SKAction.waitForDuration(2.5)
            var run = SKAction.runBlock {
                self.banana = SKSpriteNode(imageNamed: "Banana")
                self.banana.physicsBody = SKPhysicsBody(rectangleOfSize:CGSizeMake(self.banana.frame.size.width, self.banana.frame.size.height))
                self.banana.physicsBody?.dynamic = true
                self.banana.xScale = self.frame.size.width * 0.00018
                self.banana.yScale = self.frame.size.height * 0.00023
                
                //Numero Random para que caiga
                var posicion =  Int(arc4random_uniform(3) + 1)
                switch(posicion){
                case 1:
                    self.banana.position = CGPointMake(self.frame.size.width * 0.35 + 10 , self.frame.size.height)
                    self.addChild(self.banana)
                    self.bananas++
                    break;
                case 2:
                    self.banana.position = CGPointMake(self.frame.size.width * 0.5 + 20 , self.frame.size.height)
                    self.addChild(self.banana)
                    self.bananas++
                    break;
                case 3:
                    self.banana.position = CGPointMake(self.frame.size.width * 0.65 , self.frame.size.height)
                    self.addChild(self.banana)
                    self.bananas++
                    break;
                default:
                    break;
                }
            }
            self.runAction(SKAction.repeatAction((SKAction.sequence([wait, run])), count: 10))
        }
    }

    
    override func didMoveToView(view: SKView) {
        var viewController: UIViewController?
        //Agregar Fondo
        var bgImage = SKSpriteNode(imageNamed: "back_timmy.jpg")
        bgImage.xScale = self.frame.size.width * 0.0004
        bgImage.yScale = self.frame.size.height * 0.00052
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        self.addChild(bgImage)
        
        //Agregar imagen a sprite
        var spritetexture = SKTexture(imageNamed:"Mono1")
        var spritetexture2 = SKTexture(imageNamed:"Mono2")
        var spritetexture3 = SKTexture(imageNamed:"Mono3")
        var spritetexture4 = SKTexture(imageNamed:"Mono4")
        var spritetexture5 = SKTexture(imageNamed:"Mono5")
        var spritetexture6 = SKTexture(imageNamed:"Mono6")
        self.mono = SKSpriteNode(texture: spritetexture)
        
        //Agregarlo a pantalla y agregarle sus Physics Body
        mono.xScale = self.frame.size.width * 0.00018
        mono.yScale = self.frame.size.height * 0.00023
        self.mono.position = CGPointMake(self.frame.size.width/2 , 200)
        self.addChild(mono)
        
        //PlayMusic
        playMySound()
        
        //Agregar Objetos transparentes
        self.canasta.xScale = self.frame.size.width * 0.00018
        self.canasta.yScale = self.frame.size.height * 0.00023
        self.canasta.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 10))
        self.canasta.position = CGPointMake(self.frame.size.width/2 ,self.frame.size.height/2 - 83)
        self.canasta.physicsBody?.dynamic = false
        self.addChild(self.canasta)
        
        //Collisions
        let bananaCategory: UInt32 = 0x1 << 0
        let canastaCategory: UInt32 = 0x1 << 2

        physicsWorld.contactDelegate = self
        banana.physicsBody?.categoryBitMask = bananaCategory // 3
        banana.physicsBody?.contactTestBitMask = bananaCategory // 4
        canasta.physicsBody?.categoryBitMask = canastaCategory
        canasta.physicsBody?.contactTestBitMask = bananaCategory

        
        //Animacion
        var animationstart = SKAction.animateWithTextures([spritetexture, spritetexture2, spritetexture3, spritetexture4, spritetexture5], timePerFrame: 0.4)
        self.mono.runAction(animationstart)
        
        //Label
        self.labelTime.text = String(bananascachadas);
        self.labelTime.fontSize = 30;
        self.labelTime.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 50)
        self.addChild(labelTime)
        
        //Loop para que caigan las bananas
        bananacai()
    }
    
    func returnToMainMenu(){
        BkPlayer.stop()
        var vc: UIViewController = UIViewController()
        self.viewController?.performSegueWithIdentifier("Menu", sender: vc)
    }
    
    func changelabel(){
        self.labelTime.removeFromParent()
        self.labelTime.text = String(self.bananascachadas);
        self.addChild(labelTime)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                self.bananascachadas++
                changelabel()
                banana.removeFromParent()
            }
    }
    
    func Regresarcanastaalcentro(){
//        self.mono.runAction(SKAction.moveTo(CGPointMake(self.frame.size.width/2 ,self.frame.size.height/2 - 83), duration: 0.9))
        self.canasta.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 10))
        self.canasta.position = CGPointMake(self.frame.size.width/2 ,self.frame.size.height/2 - 83)
        self.canasta.physicsBody?.dynamic = false
        self.canasta.xScale = self.frame.size.width * 0.00018
        self.canasta.yScale = self.frame.size.height * 0.00023
        let bananaCategory: UInt32 = 0x1 << 0
        let canastaCategory: UInt32 = 0x1 << 2
        self.canasta.physicsBody?.categoryBitMask = canastaCategory
        self.canasta.physicsBody?.contactTestBitMask = bananaCategory
        self.addChild(self.canasta)
    }
    
override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    /* Called when a touch begins */
    
    for touch: AnyObject in touches {
        let location = touch.locationInNode(self)
        var width = location.x
        var spritetexture5 = SKTexture(imageNamed:"Mono5")
        var spritetexture4 = SKTexture(imageNamed:"Mono4")
        var spritetexture6 = SKTexture(imageNamed:"Mono6")
        var wait = SKAction.waitForDuration(0.3)
        var wait2 = SKAction.waitForDuration(0.3)
        
        if width < self.frame.size.width/2 {
            var animationstart = SKAction.animateWithTextures([spritetexture5, spritetexture6, spritetexture5], timePerFrame: 0.3)
            self.mono.runAction(animationstart)
            var run1 = SKAction.runBlock {
            self.canasta.removeFromParent()
            self.canasta.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 10))
            self.canasta.position = CGPointMake(self.frame.size.width * 0.35 + 10 , self.frame.size.height/2 - 183)
            self.canasta.physicsBody?.dynamic = false
            self.canasta.xScale = self.frame.size.width * 0.00018
            self.canasta.yScale = self.frame.size.height * 0.00023
            self.addChild(self.canasta)
            let bananaCategory: UInt32 = 0x1 << 0
            let canastaCategory: UInt32 = 0x1 << 2
            self.canasta.physicsBody?.categoryBitMask = canastaCategory
            self.canasta.physicsBody?.contactTestBitMask = bananaCategory
            }
            var run = SKAction.runBlock {
                self.canasta.removeFromParent()
                self.Regresarcanastaalcentro()
            }
            self.runAction(SKAction.sequence([wait, run1, wait2, run]))
            
        } else {
            var animationstart = SKAction.animateWithTextures([spritetexture5, spritetexture4, spritetexture5], timePerFrame: 0.3)
            self.mono.runAction(animationstart)
            self.canasta.removeFromParent()
            var run3 = SKAction.runBlock {
            self.canasta.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 10))
            self.canasta.position = CGPointMake(self.frame.size.width * 0.65 , self.frame.size.height/2 - 183)
            self.canasta.physicsBody?.dynamic = false
            self.canasta.xScale = self.frame.size.width * 0.00018
            self.canasta.yScale = self.frame.size.height * 0.00023
            self.addChild(self.canasta)
            let bananaCategory: UInt32 = 0x1 << 0
            let canastaCategory: UInt32 = 0x1 << 2
            self.canasta.physicsBody?.categoryBitMask = canastaCategory
            self.canasta.physicsBody?.contactTestBitMask = bananaCategory
            }
            var run2 = SKAction.runBlock {
                self.canasta.removeFromParent()
                self.Regresarcanastaalcentro()
            }
            self.runAction(SKAction.sequence([wait, run3, wait2,run2]))
        }
        
    }
    if bananascachadas >= 10 {
        returnToMainMenu()
    } else if bananascachadas <= 10 && bananas >= 10 {
        returnToMainMenu()
    }
}

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
