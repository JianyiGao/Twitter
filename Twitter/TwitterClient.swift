//
//  TwitterClient.swift
//  Twitter
//
//  Created by Jianyi Gao 高健一 on 2/5/17.
//  Copyright © 2017 Jianyi Gao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "bVDZzkBHDoO5OIpz0RQgSSUE8", consumerSecret: "Han4HodyaMieVfnHUMUMIiWpq8WTIAheczoPcsGYKTorOdYaWY")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    // How to declare a closure type
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            // print ("Got a token.")
            
            
            
            let requestTokenString = (requestToken?.token)! as String
            // print(requestTokenString)
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestTokenString)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }) { (error: Error?) in
            print("Error in login: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        // Besides logout account, delete saved account, user should leave current tweets view and go to login view
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
    }
    
    func handleOpenUrl(url: URL){
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            // print ("Got the access token.")
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) -> () in
                self.loginFailure?(error)
            })
            
            
            
            self.loginSuccess?()
            
            
        }, failure: { (error: Error?) in
            // print ("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })

        
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            
            success(user)
            
            print("name: \(user.name)")
            print("screenName: \(user.screenName)")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.tagline)")
            
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
            
        })
        
    }
    
    // Closure
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
            
        })
        
        
        
        
    }


    
}
