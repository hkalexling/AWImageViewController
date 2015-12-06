# AWImageViewController
A neat image viewer written in Swift

##Demo GIF

![](https://github.com/hkalexling/AWImageViewController/blob/master/Media/Demo.gif)

##Features

Basically everything you will expect for an image viewer:

- Double taps to zoom in/out
- Single tap to dismiss
- Pan when zoomed in
- Long press to bring up action sheet (customisable)
- Different background effects to choose from (three blur effects and one simple black background)
- Transition with animation
- [WIP] download image from web


##Usage

Apple's `UIImage+ImageEffects` category is required. You can find the source [here](https://developer.apple.com/library/ios/samplecode/UIImageEffects/Listings/UIImageEffects_UIImageEffects_h.html). The two files are also included in this repo: [UIImage+ImageEffects.h](https://github.com/hkalexling/AWImageViewController/blob/master/AWImageViewController/UIImage%2BImageEffects.h), [UIImage+ImageEffects.m](https://github.com/hkalexling/AWImageViewController/blob/master/AWImageViewController/UIImage%2BImageEffects.m)

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

####Delegates:

- `AWImageViewControllerDelegate`: Conform to this delegate and implement its delegate method `awImageViewDidDismiss()` to get callback when the image viewer has been dismissed
- `AWImageViewControllerLongPressDelegate`: Conform to this delegate and implement its delegate method `awImageViewDidLongPress()` to override what will happen when user perform long press on the image

####Others:

For more detail usages, please refer to the [Demo app](https://github.com/hkalexling/AWImageViewController/tree/master/AWImageViewController) included in this repo

##Todo

- [ ] Integrate an image downloader to download image from a given url
