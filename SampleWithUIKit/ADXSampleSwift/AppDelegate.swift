//
//  AppDelegate.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit

import FBAudienceNetwork
import AppTrackingTransparency
import ADXLibrary

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // ADX SDK Initialize
        let configuration = ADXConfiguration(appId: ADX_APP_ID, 
                                             gdprType: .popupLocation,
                                             testDevices: [])
        
        ADXSdk.sharedInstance().initialize(with: configuration) { result, consentState in
            print("ADX SDK Initialize")
        }
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // 프로그래밍 방식으로 수동으로 ATT (App Tracking Transparency) 동의 요청 할 경우에만, 아래 코드를 사용.
        // requestIDFA()
        
        // 애드몹 UMP (User Messaging Platform)의 IDFA 메시지를 통한 ATT (App Tracking Transparency) 동의 요청 권장
        // 참조 링크: https://docs.adxcorp.kr/appendix/ump-user-messaging-platform
    }
    
    func requestTrackingPermission(completion: @escaping (Bool) -> Void) {
        guard #available(iOS 14, *) else {
            return DispatchQueue.main.async { completion(true) }
        }
        let currentStatus = ATTrackingManager.trackingAuthorizationStatus
        if currentStatus == .authorized {
            return DispatchQueue.main.async { completion(true) }
        } else if currentStatus == .denied || currentStatus == .restricted {
            return DispatchQueue.main.async { completion(false) }
        }
        
        func request() {
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async { completion(status == .authorized) }
            }
        }
        if UIApplication.shared.applicationState == .active {
            request()
            return
        }
        var observer: NSObjectProtocol?
        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { _ in
            if let obs = observer {
                NotificationCenter.default.removeObserver(obs)
                observer = nil
                request()
            }
        }
    }
}
