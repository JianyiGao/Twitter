//
//  Tweet.swift
//  Twitter
//
//  Created by Jianyi Gao 高健一 on 2/5/17.
//  Copyright © 2017 Jianyi Gao. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0

    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0 // If it exist, use it; othrwise use 0 
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        let timeStampString = dictionary["created_at"] as? String
    
        if let timeStampString = timeStampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString)
        }

    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{ // This function will retuen with an array of tweets 
        
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}














