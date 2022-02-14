//
//  BannerViewController.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit
import ADXLibrary

class BannerViewController: UIViewController {
    fileprivate var adView : ADXAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adView = ADXAdView(adUnitId: ADX_BANNER_AD_UNIT_AD, adSize: ADXAdSizeBanner, rootViewController: self)
        adView.frame = CGRect(x: (UIScreen.main.bounds.size.width - ADXAdSizeBanner.width) / 2,
                              y: 0,
                              width: ADXAdSizeBanner.width,
                              height: ADXAdSizeBanner.height)
        adView.delegate = self
        view.addSubview(adView)
        adView.loadAd()
    }
}

extension BannerViewController: ADXAdViewDelegate {
    
    func adViewDidLoad(_ adView: ADXAdView) {
        print("adViewDidLoad");
    }
    
    func adView(_ adView: ADXAdView, didFailToLoadWithError error: Error) {
        print("didFailToLoadWithError")
    }
    
    func adViewDidClick(_ adView: ADXAdView) {
        print("adViewDidClick")
    }
}
