<div align=center>
<img align=center src="logo.png" alt="SimpleParallax Logo" width="350" height="222">
<br/><br/><br/>  
<p style="color: #403956; margin-top: 40px;">
Beautiful &amp; simple parallax effects for your UI. 🌁 Perfect for Onboarding & Login/Signup screens - Recreate the well-known iOS wallpaper animation by dividing your ViewController in background, middleground and foreground elements which each receive different motionEffects.
</p>
<br/><br/>
<img align=center src="simpleParallaxDemo.gif" alt="SimpleParallax Animation GIF" width="800" height="600">
</div>

<h1>Usage</h1>
<p style="color: #403956; margin-top: 40px;">
SimpleParallax works by extending UIView. In order to apply a Parallax-MotionEffect to one of your UIView-objects, simply call one of the following methods:</p><br/>

* addBackgroundPxEffect()
* addMiddlegroundPxEffect()
* addForegroundPxEffect()  

<br/>
<p style="color: #403956; margin-top: 40px;">Furthermore, you can specify the <b>strength</b> of the Parallax-effect: </br>If you don't pass the strength as an argument, <b>.Mid</b> is used by default.</p>

```swift

enum ParallaxStrength {
    case Low
    case Mid
    case High
}  

```

</br>
<h3>Example implementation in viewDidLoad():</h3>

```swift
  
override func viewDidLoad() {
        super.viewDidLoad()
        //Lets assign our Backgrounds:
        background2.addBackgroundPxEffect(strength: .Low)
        background1.addBackgroundPxEffect(strength: .Mid)
        
        //Lets assign our Middleground:
        titleLabel.addMiddlegroundPxEffect()
        
        //Lets assign our Foreground:
        startButton.addForegroundPxEffect(strength: .High)
    }
```
</br>
<h3>Installation</h3>
<p style="color: #403956; margin-top: 40px;">
Import/copy 📄 <b>SimpleParallax.swift</b> into the directory of your project - Done!</p><br/>
