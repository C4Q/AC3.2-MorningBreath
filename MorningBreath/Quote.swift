//
//  Quote.swift
//  MorningBreath
//
//  Created by Karen Fuentes on 11/8/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import Foundation

class Quote {
    var quote: String
    var author: String
    
    init(quote:String, author:String) {
        self.quote = quote
        self.author = author
    }
    
    static func getDailyLifeQuote (from data: Data) -> Quote? {
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dictionary = jsonData as? [String:AnyObject] else{return nil}
            guard let contents = dictionary["contents"] as? [String:AnyObject] else {return nil}
            guard let quotesInfoArray = contents["quotes"] as? [[String:AnyObject]] else {return nil}
            guard let actualQuote = quotesInfoArray[0]["quote"]as? String else {return nil}
            guard let author = quotesInfoArray[0]["author"] as? String else {return nil}
            
            let q = Quote(quote: actualQuote, author: author)
            
            return q
        }
            
        catch {
            print("ERRRROOOOORRR")
        }
        return nil
    }
}
