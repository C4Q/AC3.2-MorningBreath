//
//  News.swift
//  MorningBreath
//
//  Created by Karen Fuentes, Thinley Dorjee, Victor Zhong on 11/7/16.
//  Copyright © 2016 Karen Fuentes, Thinley Dorjee, Victor Zhong. All rights reserved.
//


import Foundation

enum NewsModelParseError: Error {
	case results(json: Any)
	case title(title: Any)
	case description(description: Any)
	case url(url: Any)
}

class News {
	let title:			String
	let description:	String
	let url:			String
	
	init(
		title:			String,
		description:	String,
		url:			String
		) {
		self.title =		title
		self.description =	description
		self.url =			url
	}
	
	convenience init?(from dictionary: [String:AnyObject]) throws {
		guard let title = dictionary["title"] as? String else {
			throw NewsModelParseError.title(title: dictionary["title"] as Any)
		}
		
		guard let description = dictionary["description"] as? String else {
			throw NewsModelParseError.description(description: dictionary["description"] as Any)
		}
		
		guard let url = dictionary["url"] as? String else {
			throw NewsModelParseError.url(url: dictionary["url"] as Any)
		}
		
		self.init(
			title:			title,
			description:	description,
			url:			url
		)
	}
	
	static func getNews(from data: Data) -> [News]? {
		var newsToReturn: [News]? = []
		
		do {
			let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
			
			guard let response: [String : AnyObject] = jsonData as? [String : AnyObject],
				let items: [[String : AnyObject]] = response["articles"] as? [[String : AnyObject]]
				else {
					throw NewsModelParseError.results(json: jsonData)
			}
			
			for newsDict in items {
				if let article = try News(from: newsDict) {
					newsToReturn?.append(article)
					print("We have APOD data!")
				}
			}
		}
		catch let NewsModelParseError.results(json: json)  {
			print("Error encountered with parsing 'Generic' or 'items' key for object: \(json)")
		}
		catch {
			print("Unknown parsing error: \(error)")
		}
		
		return newsToReturn
	}
}

// Example calls and API references below
/*
{
status: "ok",
source: "the-washington-post",
sortBy: "top",
articles: [
{
author: "Sean Sullivan, Anne Gearan, Greg Jaffe",
title: "Clinton and Trump in last-day dash with FBI email probe over but not forgotten",
description: "Clinton campaign seeks to put FBI “ruckus” behind; Trump urges voters to “deliver justice at the ballot box.”",
url: "https://www.washingtonpost.com/politics/clinton-and-trump-in-last-day-dash-with-fbi-email-probe-over-but-not-forgotten/2016/11/07/01f9ced0-a4e7-11e6-8fc0-7be8f848c492_story.html",
urlToImage: "https://img.washingtonpost.com/rf/image_1484w/2010-2019/WashingtonPost/2016/11/07/National-Politics/Images/APTOPIX_Campaign_2016_Clinton-47d70.jpg",
publishedAt: "2016-11-07T07:29:00Z"
},
*/
