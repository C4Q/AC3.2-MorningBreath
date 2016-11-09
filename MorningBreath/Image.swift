//
//  Image.swift
//  MorningBreath
//
//  Created by Karen Fuentes, Thinley Dorjee, Victor Zhong on 11/7/16.
//  Copyright © 2016 Karen Fuentes, Thinley Dorjee, Victor Zhong. All rights reserved.
//


import Foundation

class Image{
	let id: Int
	let image: String
	
	init(id: Int, image: String) {
		self.id = id
		self.image = image
	}
	
	static func ArrOfImage(from data: Data) -> [Image]?{
		var AllImageToReturn = [Image]()
		do{
			let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
			guard let response = jsonData as? [String: AnyObject] else {return nil}
			guard let images = response["images"] as? [[String: Any]] else {return nil}
			print("111111:\(images)")
			
			for imageDict in images{
				guard let imageId = imageDict["id"] as? Int,
					let imageUrl = imageDict["url"] as? String else {return nil}
				print("!!!!!!!!!!:\(imageId)")
				print("!!!!!!!!!!:\(imageUrl)")
				
				let allData = Image(id: imageId, image: imageUrl)
				AllImageToReturn.append(allData)
			}
			return AllImageToReturn
			
		}
		catch let error as NSError{
			print("Error encountered: \(error)")
		}
		return nil
	}
	
}
