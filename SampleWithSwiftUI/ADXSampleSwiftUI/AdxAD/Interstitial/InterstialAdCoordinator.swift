//
//  InterstialAdCoordinator.swift
//  ADXSampleSwiftUI
//
//  Created by JCLEE on 2023/05/17.
//

import UIKit
import ADXLibrary

class InterstialAdCoordinator: NSObject, ObservableObject {

    @Published var isLoaded: Bool = false
    private var interstitialAd: ADXInterstitialAd?
    private let unitId:String = "6200fef52a918d0001000007"
    
    func loadAd() {
        interstitialAd = ADXInterstitialAd(adUnitId:unitId)
        interstitialAd?.delegate = self
        interstitialAd?.load()
    }
    
    func presentAd() {
        guard let interstitialAd = self.interstitialAd else { return }
        self.isLoaded = interstitialAd.isLoaded
        if interstitialAd.isLoaded == false {
            print("AD is not loaded yet")
            return
        }
        
        guard let rootVC = AdCommonUtil.getRootViewController() else {
            print("rootViewController is nil")
            return;
        }
        self.isLoaded = false
        interstitialAd.show(fromRootViewController: rootVC)
    }
}

extension InterstialAdCoordinator: ADXInterstitialAdDelegate {
    
    func interstitialAdDidLoad(_ interstitialAd: ADXInterstitialAd) {
        print("interstitialAdDidLoad")
        self.isLoaded = interstitialAd.isLoaded
    }
    
    func interstitialAd(_ interstitialAd: ADXInterstitialAd, didFailToLoadWithError error: Error) {
        print("interstitialAd didFailToLoadWithError")
    }
    
    func interstitialAd(_ interstitialAd: ADXInterstitialAd, didFailToShowWithError error: Error) {
        print("interstitialAd didFailToShowWithError")
    }
    
    func interstitialAdDidDismissScreen(_ interstitialAd: ADXInterstitialAd) {
        print("interstitialAdDidDismissScreen")
    }
    
    func interstitialAdDidClick(_ interstitialAd: ADXInterstitialAd) {
        print("interstitialAdDidClick")
    }
    
}

