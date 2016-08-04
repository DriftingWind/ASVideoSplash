# ASVideoSplash
========================
ASVideoSplash is a sample explain how to set a Video as splash in the first launching of your application this feature i made it before in one of my applications with Objective-c so i separate it to be a useful component with Swift



![ASVideoSplash](https://github.com/AhmedAskar/ASVideoSplash/blob/master/Shoot2.png)


To use the ASHorizontalScrollerPaging please do the following:


# Usage

```
//Add these outlets
@IBOutlet weak var viedoView: UIView!
@IBOutlet weak var contentView: UIView!

Add the following lines of code to your ViewDidLoad:
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

```

Then check the sample you will find what you need

# License

This code is licensed under the terms of the MIT License.

[@AhmedAskar](https://www.linkedin.com/in/ahmed-askar-8a093244?trk=hp-identity-photo)