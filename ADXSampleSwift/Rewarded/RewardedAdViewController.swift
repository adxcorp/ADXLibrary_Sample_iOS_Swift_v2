//
//  RewardedAdViewController.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit
import ADXLibrary

class RewardedAdViewController: UIViewController {
    fileprivate var rewardedAd: ADXRewardedAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewardedAd = ADXRewardedAd(adUnitId: ADX_REWARDED_AD_UNIT_ID)
        rewardedAd.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loadAd(_ sender: Any) {
        rewardedAd.load()
    }
    
    @IBAction func showAd(_ sender: Any) {
        if rewardedAd.isLoaded {
            rewardedAd.show(fromRootViewController: self)
        }
    }
}

extension RewardedAdViewController: ADXRewardedAdDelegate {
    func rewardedAdDidLoad(_ rewardedAd: ADXRewardedAd) {
        print("rewardedAdDidLoad")
    }
    
    func rewardedAd(_ rewardedAd: ADXRewardedAd, didFailToLoadWithError error: Error) {
        print("rewardedAd:didFailToLoadWithError")
    }
    
    func rewardedAd(_ rewardedAd: ADXRewardedAd, didFailToShowWithError error: Error) {
        print("rewardedAd:didFailToShowWithError")
    }
    
    func rewardedAdWillPresentScreen(_ rewardedAd: ADXRewardedAd) {
        print("rewardedAdWillPresentScreen")
    }
    
    func rewardedAdWillDismissScreen(_ rewardedAd: ADXRewardedAd) {
        print("rewardedAdWillDismissScreen")
    }
    
    func rewardedAdDidDismissScreen(_ rewardedAd: ADXRewardedAd) {
        print("rewardedAdDidDismissScreen")
    }
    
    func rewardedAdDidClick(_ rewwaredAd: ADXRewardedAd) {
        print("rewardedAdDidClick")
    }
    
    func rewardedAdDidRewardUser(_ rewwaredAd: ADXRewardedAd, with reward: ADXReward) {
        print("rewardedAdDidRewardUser")
    }
}
