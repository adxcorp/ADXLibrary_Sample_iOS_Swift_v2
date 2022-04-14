//
//  AppDelegate.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit

import ADXLibrary
import FBAudienceNetwork
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // ADX SDK Initialize
        let configuration = ADXConfiguration(appId: ADX_APP_ID, gdprType: .popupLocation)
        configuration.logLevel = .debug
        
        ADXSdk.sharedInstance().initialize(with: configuration) { result, consentState in
            print("ADX SDK Initialize")
        }
        
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = .white
            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            UINavigationBar.appearance().isTranslucent = false
        }
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        requestIDFA()
    }
    
    func requestIDFA() {
        if #available(iOS 14, *) {
            // ATT 알림을 통한 권한 요청
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                // 광고추적제한 설정 (페이스북 광고 ATE 설정)
                if (status == .authorized) {
                    FBAdSettings.setAdvertiserTrackingEnabled(true)
                } else {
                    FBAdSettings.setAdvertiserTrackingEnabled(false)
                }
            })
        }
    }
}
