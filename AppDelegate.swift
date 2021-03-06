//
//  AppDelegate.swift
//  SmartHome
//
//  Created by Manav Maroli on 10/25/17.
//  Copyright © 2017 Bluetooth is OK. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let locationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Set default user settings
        
        if defaults.value(forKey: PreferencesKeys.city) == nil {
            defaults.set("Los Angeles", forKey: PreferencesKeys.city)
        }
        if defaults.value(forKey: PreferencesKeys.units) == nil {
            defaults.set("Fahrenheit (°F)", forKey: PreferencesKeys.units)
        }
        if defaults.value(forKey: PreferencesKeys.ipAddress) == nil {
            defaults.set(URL(string: "http://74.213.228.138"), forKey: PreferencesKeys.ipAddress)
        }
        if defaults.value(forKey: PreferencesKeys.automateDevice) == nil {
            defaults.set(true, forKey: PreferencesKeys.automateDevice)
        }
        
        // Configure locationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
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
    
}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            defaults.set(true, forKey: PreferencesKeys.atHome)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            defaults.set(false, forKey: PreferencesKeys.atHome)
        }
    }
}
