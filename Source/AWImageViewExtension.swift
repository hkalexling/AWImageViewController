//
//  AWImageViewExtension.swift
//  AWImageViewController
//
//  Created by Alex Ling on 6/12/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
	class func imageWithColorAndSize(color : UIColor, size : CGSize) -> UIImage {
		let rect = CGRectMake(0, 0, size.width, size.height)
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		color.setFill()
		UIRectFill(rect)
		let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
	
	class func imageFromUIView(view : UIView) -> UIImage{
		UIGraphicsBeginImageContext(view.frame.size)
		view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image
	}
}