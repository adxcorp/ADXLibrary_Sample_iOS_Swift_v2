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
        adView.translatesAutoresizingMaskIntoConstraints = false
        adView.delegate = self
        view.addSubview(adView)
        NSLayoutConstraint.activate([
            adView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            adView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            adView.widthAnchor.constraint(equalToConstant: ADXAdSizeBanner.width),
            adView.heightAnchor.constraint(equalToConstant: ADXAdSizeBanner.height)
        ])
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
