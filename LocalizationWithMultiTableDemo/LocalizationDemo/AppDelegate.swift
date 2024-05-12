//
//  AppDelegate.swift
//  LocalizationDemo
//
//  Created by Piyush Sinroja on 12/03/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        StorageService.shared.preferedLanguage = LanguageCode.ja.rawValue
        return true
    }
}

