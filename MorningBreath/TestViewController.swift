//
//  TestViewController.swift
//  MorningBreath
//
//  Created by Victor Zhong on 11/8/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UIWebViewDelegate {
	
	@IBOutlet weak var webViewTest: UIWebView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let url = NSURL (string: "http://service.mta.info/ServiceStatus/status.html?widget=yes")
		let requestObj = NSURLRequest(url: url! as URL)
		webViewTest.loadRequest(requestObj as URLRequest)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
