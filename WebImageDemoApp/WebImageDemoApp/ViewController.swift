//
//  ViewController.swift
//  WebImageDemoApp
//
//  Created by Alex Ling on 6/12/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var awImageView : AWImageViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func tapped(sender: UIButton) {
		self.awImageView = AWImageViewController()
		
		self.awImageView.setupWithUrl("http://konachan.com/sample/94e60b887588689c6f641d2058edc1fe/Konachan.com%20-%20162647%20sample.jpg", parentView: self.view, backgroundStyle: nil, animationDuration: nil, delegate: nil, longPressDelegate: nil)
		
		self.view.addSubview(self.awImageView.view)
	}
}

