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

let ADX_APP_ID                   = "6200fea42a918d0001000001"
let ADX_BANNER_AD_UNIT_AD        = "6200fee42a918d0001000003"
let ADX_MREC_AD_UNIT_AD          = "6200feeb2a918d0001000005"
let ADX_INTERSTITIAL_AD_UNIT_ID  = "6200fef52a918d0001000007"
let ADX_NATIVE_AD_UNIT_ID        = "6200fefc2a918d0001000009"
let ADX_REWARDED_AD_UNIT_ID      = "6200ff0c2a918d000100000d"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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
                
                self.initializeSdk()
            })
            
        } else {
            self.initializeSdk()
        }
    }
    
    func initializeSdk() {
        let configuration = ADXConfiguration(appId: ADX_APP_ID, gdprType: .popupLocation)
        configuration.logLevel = .debug
        
        ADXSdk.sharedInstance().initialize(with: configuration) { result, consentState in
            print("ADX SDK Initialize")
        }
    }
}

