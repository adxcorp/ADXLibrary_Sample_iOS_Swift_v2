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
            
            let nativeAdView = ADXNativeAdFactory.sharedInstance().getNativeAdView(ADX_NATIVE_AD_UNIT_ID)
            nativeAdView?.frame = CGRect(x: (UIScreen.main.bounds.width - 320.0)/2,
                                         y: 100.0,
                                         width: 320.0,
                                         height: 300.0)
            self.view.addSubview(nativeAdView!)
            
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
