//
//  ASVideoSplasViewController.swift
//  VideoSplash
//
//  Created by Ahmed Askar on 7/2/16.
//  Copyright © 2016 Askar. All rights reserved.
//

import UIKit
import AVFoundation

class ASVideoSplasViewController: UIViewController {
    
    var timer: NSTimer!
    var player:AVPlayer!
    var imgV_Back: UIImageView!
    
    @IBOutlet weak var viedoView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController!.navigationBarHidden = true

        //Not affecting background video playing
        let audioSession : AVAudioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioSession.setActive(true)
        
        //Set up player
        let urlPath  = NSBundle.mainBundle().pathForResource("Movie", ofType: "mp4")
        let movieURL = NSURL.fileURLWithPath(urlPath!)
        let avAsset  = AVAsset.init(URL: movieURL)
        let avPlayerItem = AVPlayerItem.init(asset: avAsset)
        self.player = AVPlayer.init(playerItem: avPlayerItem)
        let avPlayerLayer = AVPlayerLayer.init(player: self.player)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayerLayer.frame = UIScreen.mainScreen().bounds
        self.viedoView.layer.addSublayer(avPlayerLayer)
        
        //Config player
        self.player.seekToTime(kCMTimeZero)
        self.player.volume = 0.0
        self.player.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        self.player.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(playerItemDidReachEnd),
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: self.player.currentItem)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(playerStartPlaying),
                                                         name:UIApplicationDidBecomeActiveNotification,
                                                         object:nil)
        
        self.performSelector(#selector(self.animate), withObject: nil, afterDelay: 1)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.player.pause()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.player.play()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
    }
    
    // MARK: -
    // MARK: Functions
    func playerStartPlaying() {
        self.player.play()
    }
    
    func animate(block: () -> Void) {

            UIView.animateWithDuration(0.6, delay: 0, options:UIViewAnimationOptions.CurveEaseIn, animations: {() -> Void in
                self.view.alpha = 1
                }, completion: {(finished: Bool) -> Void in
                    UIView.animateWithDuration(1, delay: 6.0, options: [], animations: {() -> Void in
                        self.header.alpha = 1.0
                        self.signIn.alpha = 1.0
                        self.signUp.alpha = 1.0
                        }, completion:nil)
            })
    }
    
    func playerItemDidReachEnd(notification: NSNotification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seekToTime(kCMTimeZero)
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

