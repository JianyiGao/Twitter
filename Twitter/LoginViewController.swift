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
        
        TwitterClient.sharedInstance?.login(success: {
            print("Logged in.")
            
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            
        }, failure: { (error: Error) in
            print ("Error in onLoginButton: \(error.localizedDescription)")
        })
        
        
        
        
        
                
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
