//
//  NativeAdView.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit
import ADXLibrary

class NativeAdView: UIView {
    var titleLabel: UILabel!
    var mainTextLabel: UILabel!
    var callToActionButton: UIButton!
    var iconImageView: UIImageView!
    var privacyInformationIconImageView: UIImageView!
    var mainImageView: UIImageView!

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    func setupSubviews() {
        clipsToBounds = true
        backgroundColor = .white

        let iconImageView = UIImageView()
        iconImageView.isUserInteractionEnabled = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)
        self.iconImageView = iconImageView

        let titleLabel = UILabel()
        titleLabel.isUserInteractionEnabled = false
        titleLabel.text = "Title"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        self.titleLabel = titleLabel

        let callToActionButton = UIButton(type: .system)
        callToActionButton.contentHorizontalAlignment = .left
        callToActionButton.setTitle("Call To Action", for: .normal)
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(callToActionButton)
        self.callToActionButton = callToActionButton

        let privacyInformationIconImageView = UIImageView()
        privacyInformationIconImageView.isUserInteractionEnabled = false
        privacyInformationIconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(privacyInformationIconImageView)
        self.privacyInformationIconImageView = privacyInformationIconImageView

        let mainImageView = UIImageView()
        mainImageView.isUserInteractionEnabled = false
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainImageView)
        self.mainImageView = mainImageView

        let mainTextLabel = UILabel()
        mainTextLabel.isUserInteractionEnabled = false
        mainTextLabel.text = "Main"
        mainTextLabel.textColor = .black
        mainTextLabel.font = .systemFont(ofSize: 14)
        mainTextLabel.numberOfLines = 0
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainTextLabel)
        self.mainTextLabel = mainTextLabel

        let adTagView = UIView()
        adTagView.backgroundColor = .systemOrange
        adTagView.layer.cornerRadius = 5
        adTagView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(adTagView)

        let adTagLabel = UILabel()
        adTagLabel.isUserInteractionEnabled = false
        adTagLabel.text = "Ad"
        adTagLabel.textAlignment = .center
        adTagLabel.textColor = .white
        adTagLabel.font = .systemFont(ofSize: 17)
        adTagLabel.translatesAutoresizingMaskIntoConstraints = false
        adTagView.addSubview(adTagLabel)

        NSLayoutConstraint.activate([
            // Icon Image View
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1),

            // Title Label
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),

            // Privacy Information Icon Image View
            privacyInformationIconImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            privacyInformationIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            privacyInformationIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            privacyInformationIconImageView.widthAnchor.constraint(equalToConstant: 20),
            privacyInformationIconImageView.widthAnchor.constraint(equalTo: privacyInformationIconImageView.heightAnchor, multiplier: 1),

            // Call To Action Button
            callToActionButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            callToActionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            callToActionButton.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            callToActionButton.heightAnchor.constraint(equalToConstant: 30),
            trailingAnchor.constraint(greaterThanOrEqualTo: callToActionButton.trailingAnchor, constant: 10),

            // Main Image View
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainImageView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor, multiplier: 2),

            // Main Text Label
            mainTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainTextLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5),
            mainTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),

            // AdTag View
            adTagView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            adTagView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            adTagView.widthAnchor.constraint(equalToConstant: 30),
            adTagView.heightAnchor.constraint(equalToConstant: 20),
            adTagLabel.centerXAnchor.constraint(equalTo: adTagView.centerXAnchor),
            adTagLabel.centerYAnchor.constraint(equalTo: adTagView.centerYAnchor),
        ])
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
