//
//  ViewController.swift
//  MorningBreath
//
//  Created by Karen Fuentes, Thinley Dorjee, Victor Zhong on 11/7/16.
//  Copyright © 2016 Karen Fuentes, Thinley Dorjee, Victor Zhong. All rights reserved.
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	var news = [News]()
	var weather: Weather?
	var images = [Image]()
	var user = "Kariiiiiiiiiiiin"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadWeather()
		loadNews()
		loadImages()
	}
	
	// MARK: - Load Data code
	let synthesizer = AVSpeechSynthesizer()
	
	@IBAction func voiceButtonTapped(_ sender: UIButton) {
		guard let weather = weather else { return }
		let myUtterance = AVSpeechUtterance(string: "Good morning, \(user). You can look forward to \(weather.description) with a high of \(weather.maxTemp) degrees and a low of \(weather.minTemp) today. In other news today: \(news[0].title). \(news[0].description)")
		myUtterance.rate = 0.6
		myUtterance.pitchMultiplier = 1.3
		//		if isPaused {
		
		synthesizer.pauseSpeaking(at: .word)
		synthesizer.speak(myUtterance)
	}
	
	func loadImages() {
		let endPoint = "http://www.splashbase.co/api/v1/images/latest"
		APIRequestManager.manager.getData(endPoint: endPoint) { (data) in
			if data != nil{
				print("step 1")
				if let images = Image.ArrOfImage(from: data!){
					self.images = images
					DispatchQueue.main.async {
						//						self.tableView.reloadData()
					}
				}
			}
		}
	}
	
	func loadWeather() {
		let weatherEndpoint = "http://api.openweathermap.org/data/2.5/weather?q=new%20york%20+%20%22,us&appid=3ee9654253b3b473a0036b4bf2179181"
		APIRequestManager.manager.getData(endPoint: weatherEndpoint) { (data:Data?) in
			if data != nil {
				if let weatherInfo = Weather.getWeather(from: data!) {
					print("we got weather info")
					self.weather = weatherInfo
					DispatchQueue.main.async {
						//						self.locationLabel.text = weatherInfo.location
						//						self.descriptionLabel.text = weatherInfo.description
						//						self.maxTempLabel.text = "Maximum Temp: \(weatherInfo.maxTemp)°"
						//						self.minTempLabel.text = "Minumum Temp:\(weatherInfo.minTemp)°"
						//						self.tempLabel.text = "Temp:\(weatherInfo.temperature)°"
					}
				}
			}
		}
	}
	
	func loadNews(from outlet: String = "the-washington-post", apiKey: String = "72856ca4721f4116be898282fbff3a95") {
		let newsEndpoint = "https://newsapi.org/v1/articles?source=\(outlet)&sortBy=top&apiKey=\(apiKey)"
		
		//let escapedString = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
		APIRequestManager.manager.getData(endPoint: newsEndpoint) { (data: Data?) in
			if  let validData = data,
				let validNews = News.getNews(from: validData) {
				self.news = validNews
				dump(self.news)
				//				DispatchQueue.main.async {
				//					self.tableView?.reloadData()
				//				}
			}
		}
	}
}

