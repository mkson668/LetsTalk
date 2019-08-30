//
//  AppDelegate.swift
//  LetsTalk
//
//  Created by Aaron on 2019-08-26.
//  Copyright © 2019 Aaron Wong. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authListener: AuthStateDidChangeListenerHandle?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // test xcode version control
        FirebaseApp.configure()
        
        //auto login: this lbock of code will run every time the user login state changes but we only want this to be called once (it will run repeatedly even when the user is in the app
        // so we will make it estop after running once
        authListener = Auth.auth().addStateDidChangeListener({ (auth, user) in
            // as soon as we get something back we will stop if we do this
            Auth.auth().removeStateDidChangeListener(self.authListener!);
            
            if user != nil {
                if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil {
                    DispatchQueue.main.async {
                        self.goToApp()
                    }
                }
            }
        })
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func goToApp() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object: nil, userInfo: [kUSERID : FUser.currentId()])
        
        
        // name is Main because "Main.sotryBoard" by default. then you have to instaitate the view controller with the identifier (tabbarcontroller in this case)
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApplication") as! UITabBarController
        
        // appdelegate is not a view controller so it cannot access self.present()
        //self.present(mainView, animated: true, completion: nil)
        
        self.window?.rootViewController = mainView
        
        // show app here
    }

}

