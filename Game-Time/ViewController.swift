//
//  ViewController.swift
//  Game Time
//
//  Created by Jessica Cavazos on 3/20/15.
//  Copyright (c) 2015 TimeTeam. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var bkSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Marvin's_Dance", ofType: "mp3")!)
    var BkPlayer = AVAudioPlayer()

    @IBOutlet var btn_game1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Play Sound
        playMySound()
    }
    
    func playMySound(){
        BkPlayer = AVAudioPlayer(contentsOfURL: bkSound, error: nil)
        BkPlayer.prepareToPlay()
        BkPlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        BkPlayer.stop()
    }


}

