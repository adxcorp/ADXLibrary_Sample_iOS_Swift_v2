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
    var rewardedAd: RewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loadAd(_ sender: Any) {
        createAndLoadRewardedAd()
    }
    
    @IBAction func showAd(_ sender: Any) {
        if (rewardedAd != nil) {
            rewardedAd?.present(from: self, userDidEarnRewardHandler: {
                if let reward = self.rewardedAd?.adReward {
                    print("Reward received with currency: \(reward.type), amount \(reward.amount).")
                }
            })
        } else {
            createAndLoadRewardedAd()
        }
    }
    
    func createAndLoadRewardedAd() {
        let request = Request()
        //*** GDPR
        if ADXGdprManager.sharedInstance().consentState == .denied {
            let extras = Extras()
            extras.additionalParameters = ["npa": "1"]
            request.register(extras)
        }
        
        RewardedAd.load(with: ADMOB_REWARDED_AD_UNIT_ID, request: request) { (rewardedAd, error) in
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
extension AdMobRewardedViewController: FullScreenContentDelegate {

    func adDidRecordImpression(_ ad: any FullScreenPresentingAd) {
        print("adDidRecordImpression")
    }
    
    func adDidRecordClick(_ ad: any FullScreenPresentingAd) {
        print("adDidRecordImpression")
    }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("adDidDismissFullScreenContent")
    }
    
    func adWillPresentFullScreenContent(_ ad: any FullScreenPresentingAd) {
        print("adWillPresentFullScreenContent")
    }
    
    func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        print("Rewarded ad failed to present.")
    }
}
