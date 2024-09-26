//
//  AdMobRewardedViewController.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit

import ADXLibrary
import GoogleMobileAds

class AdMobRewardedViewController: UIViewController {
    var rewardedAd: GADRewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loadAd(_ sender: Any) {
        createAndLoadRewardedAd()
    }
    
    @IBAction func showAd(_ sender: Any) {
        if (rewardedAd != nil) {
            rewardedAd?.present(fromRootViewController: self, userDidEarnRewardHandler: {
                if let reward = self.rewardedAd?.adReward {
                    print("Reward received with currency: \(reward.type), amount \(reward.amount).")
                }
            })
        } else {
            createAndLoadRewardedAd()
        }
    }
    
    func createAndLoadRewardedAd() {
        let request = GADRequest()
        //*** GDPR
        if ADXGdprManager.sharedInstance().consentState == .denied {
            let extras = GADExtras()
            extras.additionalParameters = ["npa": "1"]
            request.register(extras)
        }
        
        GADRewardedAd.load(withAdUnitID: ADMOB_REWARDED_AD_UNIT_ID, request: request) { (rewardedAd, error) in
            if let error = error {
                print("Loading failed: \(error)")
            } else {
                print("Loading Succeeded")
                self.rewardedAd = rewardedAd;
                self.rewardedAd?.fullScreenContentDelegate = self;
            }
        }
    }

}

// MARK: - GADFullScreenContentDelegate
extension AdMobRewardedViewController: GADFullScreenContentDelegate {

    func adDidRecordImpression(_ ad: any GADFullScreenPresentingAd) {
        print("adDidRecordImpression")
    }
    
    func adDidRecordClick(_ ad: any GADFullScreenPresentingAd) {
        print("adDidRecordImpression")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("adDidDismissFullScreenContent")
    }
    
    func adWillPresentFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        print("adWillPresentFullScreenContent")
    }
    
    func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        print("Rewarded ad failed to present.")
    }
}
