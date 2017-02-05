//
//  LoginViewController.swift
//
//
//  Created by Jianyi Gao 高健一 on 1/30/17.
//
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "bVDZzkBHDoO5OIpz0RQgSSUE8", consumerSecret: "Han4HodyaMieVfnHUMUMIiWpq8WTIAheczoPcsGYKTorOdYaWY")
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            // print ("Got a token.")
            
            let requestTokenString = (requestToken?.token)! as String
            // print(requestTokenString)
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestTokenString)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }) { (error: Error?) in
            // print ("error: \(error?.localizedDescription)")
        }
        
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
