import UIKit
import ADXLibrary

class RewardAdCoordinator: NSObject, ObservableObject {

    @Published var isLoaded: Bool = false
    private var rewardedAd: ADXRewardedAd?
    private let unitId:String = "6200ff0c2a918d000100000d"
    
    func loadAd() {
        rewardedAd = ADXRewardedAd(adUnitId:unitId)
        rewardedAd?.delegate = self
        rewardedAd?.load()
    }
    
    func presentAd() {
        guard let rewardedAd = self.rewardedAd else { return }
        self.isLoaded = rewardedAd.isLoaded
        if rewardedAd.isLoaded == false {
            print("AD is not loaded yet")
            return
        }
        guard let rootVC = AdCommonUtil.getRootViewController() else {
            print("rootViewController is nil")
            return;
        }
        self.isLoaded = false
        rewardedAd.show(fromRootViewController: rootVC)
    }
}

extension RewardAdCoordinator: ADXRewardedAdDelegate {
    
    func rewardedAdDidLoad(_ rewardedAd: ADXRewardedAd) {
        print("rewardedAdDidLoad")
        self.isLoaded = rewardedAd.isLoaded
    }
    
    func rewardedAd(_ rewardedAd: ADXRewardedAd, didFailToLoadWithError error: Error) {
        print("rewardedAd:didFailToLoadWithError")
    }
    
    func rewardedAd(_ rewardedAd: ADXRewardedAd, didFailToShowWithError error: Error) {
        print("rewardedAd:didFailToShowWithError")
    }
    
    func rewardedAdDidDismissScreen(_ rewardedAd: ADXRewardedAd) {
        print("rewardedAdDidDismissScreen")
    }
    
    func rewardedAdDidClick(_ rewardedAd: ADXRewardedAd) {
        print("rewardedAdDidClick")
    }
    
    func rewardedAdDidRewardUser(_ rewardedAd: ADXRewardedAd, with reward: ADXReward) {
        print("rewardedAdDidRewardUser")
    }
}
