//
//  MRECViewController.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit
import ADXLibrary

class MRECViewController: UIViewController {
    fileprivate var adView : ADXAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adView = ADXAdView(adUnitId: ADX_MREC_AD_UNIT_AD, adSize: ADXAdSizeMediumRectangle, rootViewController: self)
        adView.frame = CGRect(x: (UIScreen.main.bounds.size.width - ADXAdSizeMediumRectangle.width) / 2,
                              y: 0,
                              width: ADXAdSizeMediumRectangle.width,
                              height: ADXAdSizeMediumRectangle.height)
        adView.delegate = self
        view.addSubview(adView)
        adView.loadAd()
    }
}

extension MRECViewController: ADXAdViewDelegate {
    
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
