//
//  AppDelegate.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/06/30.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        openRealm() //2
        print(Realm.Configuration.defaultConfiguration.fileURL!) //3
        return true
    }
        //1
    func openRealm() {
        let bundlePath = Bundle.main.path(forResource: "azamor", ofType: "realm")!
        let defaultPath = Realm.Configuration.defaultConfiguration.fileURL!.path
        let fileManager = FileManager.default

        // Only need to copy the prepopulated `.realm` file if it doesn't exist yet
        if !fileManager.fileExists(atPath: defaultPath){
            print("use pre-populated database")
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: defaultPath)
                print("Copied")
            } catch {
                print(error)
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

