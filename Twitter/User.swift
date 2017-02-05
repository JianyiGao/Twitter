//
//  User.swift
//  Twitter
//
//  Created by Jianyi Gao 高健一 on 2/5/17.
//  Copyright © 2017 Jianyi Gao. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var tagline: String?
    
    init(dictionary: NSDictionary){
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{ // If it is not nil, the first one will be unwrapped
            profileUrl = URL(string: profileUrlString)
        }
        tagline = dictionary["description"] as? String
        
        
    }


}
