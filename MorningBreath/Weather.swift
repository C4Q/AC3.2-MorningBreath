//
//  Weather.swift
//  MorningBreath
//
//  Created by Karen Fuentes, Thinley Dorjee, Victor Zhong on 11/7/16.
//  Copyright © 2016 Karen Fuentes, Thinley Dorjee, Victor Zhong. All rights reserved.
//


import Foundation

class Weather {
	var description: String
	var temperature: Int
	var minTemp: Int
	var maxTemp: Int
	var location: String
	var id: Int
	
	init (description:String, temperature:Int, minTemp:Int, maxTemp:Int, location: String, id: Int) {
		self.description = description
		self.temperature = temperature
		self.minTemp = temperature
		self.maxTemp = maxTemp
		self.location = location
		self.id = id
	}
	
	
	static func getWeather (from data: Data) -> Weather? {
		
		do {
			let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
			guard let dictionary = jsonData as? [String:AnyObject] else {return nil}
			guard let weatherArray = dictionary["weather"] as? [[String: AnyObject]] else{return nil}
			guard let weatherDescription = weatherArray[0]["description"] as? String else {return nil}
			guard let mainInfoDict = dictionary["main"] as? [String:AnyObject] else {return nil}
			guard let maxtemp = mainInfoDict["temp_max"] as? Int else {return nil}
			guard let mintemp = mainInfoDict["temp_min"] as? Int  else {return nil}
			guard let temp = mainInfoDict["temp"] as? Int else{return nil}
			guard let currentlocation = dictionary["name"] as? String else {return nil}
			guard let id = dictionary["id"] as? Int else {return nil}
			
			let w = Weather(description:weatherDescription, temperature:convertKelvin(toFahrenheit: true, kelvin: temp), minTemp:convertKelvin(toFahrenheit: true, kelvin: mintemp), maxTemp:convertKelvin(toFahrenheit: true, kelvin: maxtemp), location:currentlocation, id:id)
			
			return w
			
		}
			
		catch {
			print("ERRRROOOOORRR")
		}
		return nil
	}
	
	
	static func convertKelvin(toFahrenheit scale: Bool = true, kelvin: Int) -> Int {
		
		if scale {
			return Int((Double(kelvin) - 273.15) * 9/5 + 32)
		}
		else {
			return Int(Double(kelvin) - 273.15)
		}
	}
}
