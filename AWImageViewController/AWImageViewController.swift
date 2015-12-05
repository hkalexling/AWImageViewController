//
//  AWImageViewController.swift
//  AWImageViewController
//
//  Created by Alex Ling on 5/12/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

import UIKit

protocol AWImageViewControllerDelegate {
	func awImageViewDidDismiss()
}

class AWImageViewController: UIViewController {
	
	var delegate : AWImageViewControllerDelegate?
	
	var image : UIImage!
	var originFrame : CGRect!
	
	var scrollView : UIScrollView!
	var imageView : UIImageView!
	
	var finishedDisplaying : Bool = false
	
	var dragPoint : CGPoint = CGPointZero

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(animated: Bool) {
		
		self.scrollView = UIScrollView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
		self.view.addSubview(self.scrollView)
		
		self.imageView = UIImageView(frame: self.originFrame)
		imageView.image = self.image
		self.scrollView.addSubview(self.imageView)
		
		self.view.backgroundColor = UIColor.clearColor()
		
		let singleTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("singleTapped"))
		let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("doubleTapped"))
		doubleTapRecognizer.numberOfTapsRequired = 2
		singleTapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
		
		self.view.addGestureRecognizer(singleTapRecognizer)
		self.view.addGestureRecognizer(doubleTapRecognizer)
		
		let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("pinched:"))
		self.view.addGestureRecognizer(pinchRecognizer)
		
		self.imageView.userInteractionEnabled = true
		let panRecognizer = UIPanGestureRecognizer(target: self, action: Selector("paned:"))
		self.imageView.addGestureRecognizer(panRecognizer)
		
		self.initialAnimation()
	}
	
	func pinched(sender: UIPinchGestureRecognizer) {
		if sender.state == UIGestureRecognizerState.Ended {
			if self.imageView.frame.width < UIScreen.mainScreen().bounds.width {
				let scale : CGFloat = UIScreen.mainScreen().bounds.width / self.imageView.frame.width
				self.imageView.transform = CGAffineTransformScale(self.imageView.transform, scale, scale)
			}
		}
		else{
			self.imageView.transform = CGAffineTransformScale(self.imageView.transform, sender.scale, sender.scale)
			sender.scale = 1
		}
		self.updateContentOffset()
	}
	
	func paned(sender : UIPanGestureRecognizer){
		if self.imageView.frame.width != UIScreen.mainScreen().bounds.width {
			return
		}
		if sender.state == UIGestureRecognizerState.Began {
			self.dragPoint = sender.locationInView(self.imageView)
		}
		if sender.state == UIGestureRecognizerState.Changed{
			let currentLocation = sender.locationInView(self.view)
			let originalFrame = self.imageView.frame
			
			self.imageView.frame = CGRectMake(currentLocation.x - self.dragPoint.x, currentLocation.y - self.dragPoint.y, originalFrame.width, originalFrame.height)
		}
		if sender.state == UIGestureRecognizerState.Ended {
			UIView.animateWithDuration(0.3, animations: {
				let width : CGFloat = UIScreen.mainScreen().bounds.width
				let height : CGFloat = width * self.image.size.height/self.image.size.width
				self.imageView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height/2 - height/2, width, height)
				}, completion: {(finished : Bool) in
			})
		}
	}
	
	func singleTapped(){
		self.dismiss()
	}
	
	func doubleTapped(){
		if self.finishedDisplaying {
			self.toggleFullSize()
		}
	}
    
	func initialAnimation(){
		UIView.animateWithDuration(0.3, animations: {
			self.view.backgroundColor = UIColor.blackColor()
			let width : CGFloat = UIScreen.mainScreen().bounds.width
			let height : CGFloat = width * self.image.size.height/self.image.size.width
			self.imageView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height/2 - height/2, width, height)
			}, completion: {(finished : Bool) in
				self.finishedDisplaying = true
				self.updateContentOffset()
		})
	}
	
	func toggleFullSize(){
		if self.imageView.bounds.width == UIScreen.mainScreen().bounds.width {
			
			let width : CGFloat = self.image.size.width
			let height : CGFloat = self.image.size.height
			UIView.animateWithDuration(0.3, animations: {
				self.imageView.frame = CGRectMake(UIScreen.mainScreen().bounds.width/2 - width/2, UIScreen.mainScreen().bounds.height/2 - height/2, width, height)
				}, completion: {(finished : Bool) in
					self.updateContentOffset()
			})
		}
		else{
			UIView.animateWithDuration(0.3, animations: {
				let width : CGFloat = UIScreen.mainScreen().bounds.width
				let height : CGFloat = width * self.image.size.height/self.image.size.width
				self.imageView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height/2 - height/2, width, height)
				}, completion: {(finished : Bool) in
					self.updateContentOffset()
			})
		}
	}
	
	func dismiss(){
		UIView.animateWithDuration(0.3, animations: {
			self.view.backgroundColor = UIColor.clearColor()
			self.imageView.frame = self.originFrame
			}, completion: {(finished : Bool) in
				self.view.hidden = true //I know I shouldn't simply hide it, but if I use `self.view.removeFromSuperview()`, the `didSelectItemAtIndexPath` method in collection view controller won't get called again. I might come back and fix this later
				self.delegate?.awImageViewDidDismiss()
		})
	}
	func awImageViewDidDismiss() {}
	
	func updateContentOffset(){
		self.scrollView.contentSize = self.imageView.frame.size

		var top : CGFloat = 0
		var left : CGFloat = 0
		if self.scrollView.contentSize.width > self.scrollView.bounds.size.width {
			left = (self.scrollView.contentSize.width - self.scrollView.bounds.size.width) / 2
		}
		if self.scrollView.contentSize.height > self.scrollView.bounds.size.height {
			top = (self.scrollView.contentSize.height - self.scrollView.bounds.size.height) / 2
		}
		self.scrollView.contentInset = UIEdgeInsetsMake(top, left, -top, -left)
	}
}
