//
//  GameScene.swift
//  osoJuego
//
//  Created by Eduardo Benitez on 3/21/15.
//  Copyright (c) 2015 Eduardo Benitez. All rights reserved.
//

import SpriteKit
import AVFoundation

var arrowGenerated = 0

var arrowGenerated1 = 0
var arrowGenerated2 = 0
var arrowGenerated3 = 0
var arrowGenerated4 = 0

var userOption = 0

var arrowOption1 = 0
var arrowOption2 = 0
var arrowOption3 = 0
var arrowOption4 = 0

var numberArrows2 = 0



class OsoGameScene: SKScene {
    
    var viewController: UIViewController?
    var button1: SKNode! = nil
    var button2: SKNode! = nil
    var button3: SKNode! = nil
    var button4: SKNode! = nil
    var BkPlayer = AVAudioPlayer()
    var bkSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Sun's_Rise", ofType: "mp3")!)
    
    let backgroundImage = SKSpriteNode(imageNamed: "back_kody.jpg")
    var oso = SKSpriteNode()
    var arrow = SKSpriteNode()
    
    var texture = SKTexture(imageNamed:"Osoabajo_00001")
    
    var arrowXPos = CGFloat(50)
    
    //Arrays
    var arrowGeneratedArray:[Int] = [arrowGenerated1,arrowGenerated2,arrowGenerated3,arrowGenerated4]
    var arrowArrays:[Int] = [arrowOption1,arrowOption2,arrowOption3,arrowOption4]
    
    var numberArrows = 0
    var countArrow = 0
    
    var chances = 3
    var countDown = 10
    var counter = 0
    
    var durationArrow = NSTimer()
    var arrowsTimer = NSTimer()
    var gameTimer = NSTimer()
    
    let labelTimeLeft = SKLabelNode(fontNamed:"Helvetica")
    var labelTime = SKLabelNode(fontNamed: "Helvetica")
    
    func playMySound(){
        BkPlayer = AVAudioPlayer(contentsOfURL: bkSound, error: nil)
        BkPlayer.prepareToPlay()
        BkPlayer.play()
    }
    
    override func didMoveToView(view: SKView) {
    
        backgroundImage.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.addChild(backgroundImage)
        
        self.oso = SKSpriteNode(texture: texture)
        self.oso.xScale = self.oso.size.width * 0.0001
        self.oso.yScale = self.oso.size.height * 0.0002
        self.oso.position = CGPointMake(500,350)
        addChild(self.oso)
        
        labelTimeLeft.text = "Time left:";
        labelTimeLeft.fontSize = 30;
        labelTimeLeft.position = CGPointMake(800,600)
        self.addChild(labelTimeLeft)
        
        labelTime.text = String(countDown);
        labelTime.fontSize = 30;
        labelTime.position = CGPointMake(885, 600)
        self.addChild(labelTime)
        
        button1 = SKSpriteNode(imageNamed: "flecha_up")
        button1.position = CGPointMake(350,225)
        button1.xScale = button1.frame.size.width * 0.003
        button1.yScale = button1.frame.size.height * 0.003
        button1.name = "ButtonUp"
        self.addChild(button1)
        
        playMySound()
        
        button2 = SKSpriteNode(imageNamed: "flecha_down")
        button2.position = CGPointMake(450,225)
        button2.xScale = button2.frame.size.width * 0.002
        button2.yScale = button2.frame.size.height * 0.002
        button2.name = "ButtonDown"
        self.addChild(button2)
        
        button3 = SKSpriteNode(imageNamed: "flecha_izq")
        button3.position = CGPointMake(550,225)
        button3.xScale = button3.frame.size.width * 0.002
        button3.yScale = button3.frame.size.height * 0.002
        button3.name = "ButtonLeft"
        self.addChild(button3)
        
        button4 = SKSpriteNode(imageNamed: "flecha_der")
        button4.position = CGPointMake(650,225)
        button4.xScale = button4.frame.size.width * 0.003
        button4.yScale = button4.frame.size.height * 0.003
        button4.name = "ButtonRight"
        self.addChild(button4)

        arrowsTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("showArrows"), userInfo: nil, repeats: true)
        
    }
    
    func returnToMainMenu(){
        BkPlayer.stop()
        var vc: UIViewController = UIViewController()
        self.viewController?.performSegueWithIdentifier("Menu", sender: vc)
    }
    
    func updateTimer () {
        
        if countDown > 0 {
            
            arrowsTimer.invalidate()
            countDown--
            labelTime.text = String(countDown)
        } else {
            //Irte al menu
            returnToMainMenu()
        }
    }
    
    func timeLeft() {
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
    }
    
    func showArrows() {
        
        var randNum = Int(arc4random_uniform(3) + 1)
      
        if arrowXPos<550 {
            
            switch (randNum) {
            case 1:
                self.arrow = SKSpriteNode(imageNamed: "up")
                self.arrow.position = CGPointMake(self.frame.size.width/2, 600)
                addChild(self.arrow)
                self.arrow.xScale = self.arrow.size.width * 0.0005
                self.arrow.yScale = self.arrow.size.height * 0.0005
                arrowGenerated = randNum
                if numberArrows < 4 {
                    self.arrowGeneratedArray.append(arrowGenerated)
                    println("jaló1")
                    self.numberArrows++
                }
            
                arrowXPos += 100
                counter++
                
                var wait = SKAction.waitForDuration(0.5)
                var run = SKAction.runBlock({ () -> Void in self.arrow.removeFromParent()})
                self.runAction(SKAction.sequence([wait,run]))
                break
            case 2:
                self.arrow = SKSpriteNode(imageNamed: "down")
                self.arrow.position = CGPointMake(self.frame.size.width/2, 600)
                addChild(self.arrow)
                self.arrow.xScale = self.arrow.size.width * 0.0005
                self.arrow.yScale = self.arrow.size.height * 0.0005
                arrowGenerated = randNum
                if numberArrows < 4 {
                    self.arrowGeneratedArray.append(arrowGenerated)
                    println("jaló1")
                    self.numberArrows++
                }
                
                arrowXPos += 100
                counter++
                var wait = SKAction.waitForDuration(0.5)
                var run = SKAction.runBlock({ () -> Void in self.arrow.removeFromParent()})
                self.runAction(SKAction.sequence([wait,run]))
                break
            case 3:
                self.arrow = SKSpriteNode(imageNamed: "izq")
                self.arrow.position = CGPointMake(self.frame.size.width/2, 600)
                addChild(self.arrow)
                self.arrow.xScale = self.arrow.size.width * 0.0005
                self.arrow.yScale = self.arrow.size.height * 0.0005
                arrowGenerated = randNum
                if numberArrows < 4 {
                    self.arrowGeneratedArray.append(arrowGenerated)
                    println("jaló1")
                    self.numberArrows++
                }
                
                arrowXPos += 100
                counter++
                var wait = SKAction.waitForDuration(0.5)
                var run = SKAction.runBlock({ () -> Void in self.arrow.removeFromParent()})
                self.runAction(SKAction.sequence([wait,run]))
                break
            case 4:
                self.arrow = SKSpriteNode(imageNamed: "der")
                self.arrow.position = CGPointMake(self.frame.size.width/2, 600)
                addChild(self.arrow)
                self.arrow.xScale = self.arrow.size.width * 0.0005
                self.arrow.yScale = self.arrow.size.height * 0.0005
                arrowGenerated = randNum
                if numberArrows < 4 {
                    self.arrowGeneratedArray.append(arrowGenerated)
                    println("jaló1")
                    self.numberArrows++
                }
                
                arrowXPos += 100
                counter++
                var wait = SKAction.waitForDuration(0.5)
                var run = SKAction.runBlock({ () -> Void in self.arrow.removeFromParent()})
                self.runAction(SKAction.sequence([wait,run]))
                break
            default:
                break
            }
        }
        
        if counter == 5 {
            arrowsTimer.invalidate()
            timeLeft()
        }
    }
    
    func validate () {
        
        println("You Won")
        var valid = false
        if(arrowGeneratedArray == arrowArrays) {
            println("You Won")
        } else {
            println("You Lose")
        }
        
    }

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch: UITouch = touches.anyObject() as UITouch
        var location = touch.locationInNode(self)
        var node = self.nodeAtPoint(location)
        // If button is touched
        if numberArrows2 < 4 {
//        var run = SKAction.runBlock {
            if (node.name == "ButtonUp") {
                userOption = 1
                self.arrowArrays.append(userOption)
                println("jaló")
                numberArrows2++
        }else if (node.name == "ButtonDown") {
            userOption = 2
            self.arrowArrays.append(userOption)
            numberArrows2++
            println("jaló")
        }else if (node.name == "ButtonLeft") {
            self.arrowArrays.append(userOption)
            numberArrows2++
            println("jaló")
        }else if(node.name == "ButtonRight") {
            userOption = 4
            self.arrowArrays.append(userOption)
            println("jaló")
            numberArrows2++
            }
//        }
//        self.runAction(SKAction.repeatAction(SKAction.sequence(([run])), count: 1))
        }
        if numberArrows2 == 5{
            validate()
        }
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
