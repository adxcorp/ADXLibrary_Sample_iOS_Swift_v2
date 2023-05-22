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
        
        adView = ADXAdView(adUnitId: ADX_MREC_AD_UNIT_ID, adSize: ADXAdSizeMediumRectangle, rootViewController: self)
        adView.translatesAutoresizingMaskIntoConstraints = false
        adView.delegate = self
        view.addSubview(adView)
        NSLayoutConstraint.activate([
            adView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            adView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            adView.widthAnchor.constraint(equalToConstant: ADXAdSizeMediumRectangle.width),
            adView.heightAnchor.constraint(equalToConstant: ADXAdSizeMediumRectangle.height)
        ])
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
