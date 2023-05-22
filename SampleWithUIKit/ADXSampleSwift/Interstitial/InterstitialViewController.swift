//
//  InterstitialViewController.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit
import ADXLibrary

class InterstitialViewController: UIViewController {
    fileprivate var interstitialAd: ADXInterstitialAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interstitialAd = ADXInterstitialAd(adUnitId: ADX_INTERSTITIAL_AD_UNIT_ID);
        interstitialAd.delegate = self
    }
    
    @IBAction func loadAd(_ sender: Any) {
        interstitialAd.load()
    }
    
    @IBAction func showAd(_ sender: Any) {
        if interstitialAd.isLoaded {
            interstitialAd.show(fromRootViewController: self)
        }
    }
}

extension InterstitialViewController: ADXInterstitialAdDelegate {
    func interstitialAdDidLoad(_ interstitialAd: ADXInterstitialAd) {
        print("interstitialAdDidLoad")
    }
    
    func interstitialAd(_ interstitialAd: ADXInterstitialAd, didFailToLoadWithError error: Error) {
        print("interstitialAd didFailToLoadWithError")
    }
    
    func interstitialAd(_ interstitialAd: ADXInterstitialAd, didFailToShowWithError error: Error) {
        print("interstitialAd didFailToShowWithError")
    }
    
    func interstitialAdWillPresentScreen(_ interstitialAd: ADXInterstitialAd) {
        print("interstitialAdWillPresentScreen")
    }
    
    func interstitialAdWillDismissScreen(_ interstitialAd: ADXInterstitialAd) {
        print("interstitialAdWillDismissScreen")
    }
    
    func interstitialAdDidDismissScreen(_ interstitialAd: ADXInterstitialAd) {
        print("interstitialAdDidDismissScreen")
    }
    
    func interstitialAdDidClick(_ interstitialAd: ADXInterstitialAd) {
        print("interstitialAdDidClick")
    }
}
