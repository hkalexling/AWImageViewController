# AWImageViewController
A neat and lightweight image viewer written in Swift

##Demo GIF

- Portrait Mode:

![](https://github.com/hkalexling/AWImageViewController/blob/master/Media/Demo.gif)

- Landscape Mode:

![](https://github.com/hkalexling/AWImageViewController/blob/master/Media/LandscapeDemo.gif)

- Use Web Image:

![](https://github.com/hkalexling/AWImageViewController/blob/master/Media/WebImageDemo.gif)

##Features

Basically everything you will expect for an image viewer:

- Single tap to dismiss
- Double taps to zoom in/out
- Pinch to zoom in/out
- Pan when zoomed in
- Long press to bring up action sheet (customisable)
- Different background effects to choose from (three blur effects and one simple black background)
- Transition with animation
- download image from provided URL


##Usage

Apple's `UIImage+ImageEffects` category is required. You can find the source [here](https://developer.apple.com/library/ios/samplecode/UIImageEffects/Listings/UIImageEffects_UIImageEffects_h.html). The two files are also included in this repo: [UIImage+ImageEffects.h](https://github.com/hkalexling/AWImageViewController/blob/master/UIImage%2BImageEffects/UIImage%2BImageEffects.h), [UIImage+ImageEffects.m](https://github.com/hkalexling/AWImageViewController/blob/master/UIImage%2BImageEffects/UIImage%2BImageEffects.m)

Then add the [AWImageViewController.swift](https://github.com/hkalexling/AWImageViewController/blob/master/Source/AWImageViewController.swift) file into your project and do the following set up

####Basic usage without customisation:

```swift
class SampleClass : UIViewController {
    
    //Create instance of AWImageViewController as a global variable
    var awImageVC : AWImageViewController!
    
    //Other stuff
    
    func showImageViewer(imageView : UIImageView){
		self.awImageVC = AWImageViewController()
		
		self.awImageVC.setup(imageView, parentView: self.view, backgroundStyle: .LightBlur, animationDuration: nil, delegate: nil, longPressDelegate: nil)
				
		self.collectionView!.addSubview(self.awImageVC.view)
    }
}
```

####Download image from URL:

```swift
class SampleClass : UIViewController {
    
    //Create instance of AWImageViewController as a global variable
    var awImageVC : AWImageViewController!
    
    //Other stuff
    
    func showImageViewer(imageView : UIImageView){
		self.awImageVC = AWImageViewController()
		
		self.awImageVC.setupWithUrl("http:www.yourImageUrl.com/img.jpg", parentView: self.view, backgroundStyle: nil, animationDuration: nil, delegate: nil, longPressDelegate: nil)
		
		self.view.addSubview(self.awImageVC.view)
    }
}
```
`AWImageViewController` also provides the following variables for you to customize the progress indicator:

    progressIndicatorColor : UIColor
    progressIndicatorTextColor : UIColor
    progressIndicatorBgColor : UIColor 
    progressIndicatorShowLabel : Bool
    progressIndicatorWidth : CGFloat 
    progressIndicatorLabelFont : UIFont
    progressIndicatorRadius : CGFloat

####Delegates:

- `AWImageViewControllerDelegate`: Conform to this delegate and implement its delegate method `awImageViewDidDismiss()` to get callback when the image viewer has been dismissed
- `AWImageViewControllerLongPressDelegate`: Conform to this delegate and implement its delegate method `awImageViewDidLongPress()` to override what will happen when user perform long press on the image

####Others:

For more detail usages, please refer to the two demo apps included in this repo

##Todo

- [X] Integrate an image downloader to download image from a given URL
- [X] Use a better looking progress indicator
- [ ] Implement 3D Touch peek and pop
