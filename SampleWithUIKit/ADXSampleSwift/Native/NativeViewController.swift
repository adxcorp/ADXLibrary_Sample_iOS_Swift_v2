//
//  NativeViewController.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit
import ADXLibrary

class NativeViewController: UIViewController {
    
    var nativeAd: ADXNativeAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ADXNativeAdFactory.sharedInstance().setRenderingViewClass(ADX_NATIVE_AD_UNIT_ID, renderingViewClass: NativeAdView.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ADXNativeAdFactory.sharedInstance().add(self)
        ADXNativeAdFactory.sharedInstance().loadAd(ADX_NATIVE_AD_UNIT_ID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        ADXNativeAdFactory.sharedInstance().remove(self)
    }
    
    public func addAdTagLabel(_ nativeAdView: UIView) {
        let adTagView = UIView(frame: CGRect(x: 10, y: 2, width: 30, height: 20))
        adTagView.backgroundColor = .orange
        adTagView.layer.cornerRadius = 5
        let adTagLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        adTagLabel.text = "Ad"
        adTagLabel.textAlignment = .center
        adTagLabel.textColor = .white
        adTagView.addSubview(adTagLabel)
        adTagLabel.translatesAutoresizingMaskIntoConstraints = false
        adTagLabel.centerXAnchor.constraint(equalTo: adTagView.centerXAnchor).isActive = true
        adTagLabel.centerYAnchor.constraint(equalTo: adTagView.centerYAnchor).isActive = true
        nativeAdView.addSubview(adTagView)
    }
}

extension NativeViewController: ADXNativeAdFactoryDelegate, ADXNativeAdDelegate {
    
    // MARK: - ADXNativeAdFactoryDelegate
    public func onSuccess(_ adUnitId: String!, nativeAd: ADXNativeAd!) {
        if (adUnitId == ADX_NATIVE_AD_UNIT_ID) {
            self.nativeAd = nativeAd
            self.nativeAd?.delegate = self
            
            if let adView = ADXNativeAdFactory.sharedInstance().getNativeAdView(ADX_NATIVE_AD_UNIT_ID) {
                self.view.addSubview(adView)
                adView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    adView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    adView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0),
                    adView.widthAnchor.constraint(equalToConstant: 320.0),
                    adView.heightAnchor.constraint(equalToConstant: 300.0)
                ])
                self.view.layoutIfNeeded()
            }
            
        } else {
            print("fail to load")
        }
    }
    
    public func onFailure(_ adUnitId: String!) {
        print("onFailure : ", adUnitId!)
    }
    
    // MARK: - ADXNativeAdDelegate
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
}
