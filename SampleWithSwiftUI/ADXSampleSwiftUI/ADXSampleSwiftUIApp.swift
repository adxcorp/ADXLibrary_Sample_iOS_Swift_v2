//
//  ADXSampleSwiftUIApp.swift
//  ADXSampleSwiftUI
//
//  Created by JCLEE on 2023/05/17.
//

import SwiftUI
import ADXLibrary
import FBAudienceNetwork
import AppTrackingTransparency

@main
struct ADXSampleSwiftUIApp: App {
    
    private static let appID:String = "6200fea42a918d0001000001"
    
    init() {
    #if targetEnvironment(simulator)
    #else
        setupAdSDK()
    #endif
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension ADXSampleSwiftUIApp {
    
    func setupAdSDK() {
        let configuration = ADXConfiguration(appId: ADXSampleSwiftUIApp.appID, gdprType: .popupLocation)
        ADXSdk.sharedInstance().initialize(with: configuration) { result, consentState in
            print("ADX SDK Initialize: \(result)")
            requestIDFA()
        }
    }
    
    func requestIDFA() {
        if #available(iOS 14, *) {
            // ATT 알림을 통한 권한 요청
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                // 광고추적제한 설정 (페이스북 광고 ATE 설정)
                FBAdSettings.setAdvertiserTrackingEnabled(status == .authorized)
            })
        }
    }
    
}
