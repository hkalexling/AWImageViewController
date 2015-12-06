//
//  DemoCollectionViewController.swift
//  AWImageViewController
//
//  Created by Alex Ling on 5/12/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

import UIKit

class DemoCollectionViewController: UICollectionViewController, AWImageViewControllerDelegate {
	
	var images : [UIImage] = []
	
	let cellWidth : CGFloat = 300
	
	var awImageVC : AWImageViewController!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.collectionView!.backgroundColor = UIColor.whiteColor()
		self.collectionView!.delegate = self
		
		for i in 0...5 {
			self.images.append(UIImage(named: "\(i)")!)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 6
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
    
        cell.imageView.image = self.images[indexPath.row]
		
        return cell
    }

	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		
		return CGSize(width: self.cellWidth, height: self.cellWidth * self.images[indexPath.row].size.height/self.images[indexPath.row].size.width)
	}
	
	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		let imageView = (collectionView.cellForItemAtIndexPath(indexPath) as! ImageCollectionViewCell).imageView
		self.showImageViewer(imageView)
	}
	
	func showImageViewer(imageView : UIImageView){
		self.awImageVC = AWImageViewController()
		
		self.awImageVC.setup(imageView, parentView: self.collectionView!, backgroundStyle: AWImageViewBackgroundStyle.LightBlur, animationDuration: nil, delegate: self)
				
		self.collectionView!.addSubview(self.awImageVC.view)
		self.collectionView!.scrollEnabled = false
	}
	
	func awImageViewDidDismiss() {
		self.collectionView!.scrollEnabled = true
	}
}
