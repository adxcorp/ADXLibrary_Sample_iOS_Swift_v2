//
//  NativeAdView.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit
import ADXLibrary

class NativeAdView: UIView {
    @IBOutlet var contentsView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainTextLabel: UILabel!
    @IBOutlet var callToActionButton: UIButton!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var privacyInformationIconImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    
    convenience init() {
        self.init(frame: .zero)
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        Bundle.main.loadNibNamed("NativeAdView", owner: self, options: nil)
        addSubview(contentsView)
        
        contentsView.frame = self.bounds
        contentsView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

extension NativeAdView: ADXNativeAdRendering {
    func nativeMainTextLabel() -> UILabel! {
        return self.mainTextLabel
    }
    
    func nativeTitleTextLabel() -> UILabel! {
        return self.titleLabel
    }
    
    func nativeCallToActionButton() -> UIButton! {
        return self.callToActionButton
    }
    
    func nativeIconImageView() -> UIImageView! {
        return self.iconImageView
    }

    func nativeMainImageView() -> UIImageView! {
        return self.mainImageView
    }
    
    func nativePrivacyInformationIconImageView() -> UIImageView! {
        return self.privacyInformationIconImageView
    }
}

