//
//  ADXSampleNativeAdView.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit
import ADXLibrary

final class ADXSampleNativeAdView: UIView {

    private let containerView = UIView()

    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private let mainTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private let callToActionButton: UIButton = {
        var button = UIButton(type: .system)
        let color = UIColor.gray
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        button.setTitleColor(color, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    private let privacyInformationIconImageView = UIImageView()

    private let adTagContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        return view
    }()

    private let adTag: UILabel = {
        let label = UILabel()
        label.text = "광고"
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        adTagContainer.layer.cornerRadius = (adTag.intrinsicContentSize.height + 4) / 2
    }
}

// MARK: - Layout
extension ADXSampleNativeAdView {

    private func setupLayout() {
        adTagContainer.addSubview(adTag)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(mainTextLabel)

        [
            adTagContainer, callToActionButton,
            textStackView,
            iconImageView, mainImageView
        ].forEach {
            containerView.addSubview($0)
        }
        addSubview(privacyInformationIconImageView)
        addSubview(containerView)

        [containerView, textStackView, titleLabel, mainTextLabel, adTagContainer, adTag,
         callToActionButton, iconImageView, mainImageView, privacyInformationIconImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            // containerView
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // mainImageView
            mainImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            mainImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            mainImageView.widthAnchor.constraint(equalToConstant: 120),
            mainImageView.heightAnchor.constraint(equalToConstant: 120),

            // textStackView
            textStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 16),
            textStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textStackView.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -16),

            // iconImageView
            iconImageView.centerYAnchor.constraint(equalTo: textStackView.centerYAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 72),
            iconImageView.heightAnchor.constraint(equalToConstant: 72),

            // adTagContainer
            adTagContainer.topAnchor.constraint(greaterThanOrEqualTo: textStackView.bottomAnchor, constant: 10),
            adTagContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            adTagContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),

            // adTag
            adTag.topAnchor.constraint(equalTo: adTagContainer.topAnchor, constant: 2),
            adTag.leadingAnchor.constraint(equalTo: adTagContainer.leadingAnchor, constant: 6),
            adTag.bottomAnchor.constraint(equalTo: adTagContainer.bottomAnchor, constant: -2),
            adTag.trailingAnchor.constraint(equalTo: adTagContainer.trailingAnchor, constant: -6),

            // callToActionButton
            callToActionButton.centerYAnchor.constraint(equalTo: adTagContainer.centerYAnchor),
            callToActionButton.leadingAnchor.constraint(equalTo: adTagContainer.trailingAnchor, constant: 4),
            callToActionButton.trailingAnchor.constraint(lessThanOrEqualTo: iconImageView.leadingAnchor, constant: -16),

            // privacyInformationIconImageView
            privacyInformationIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            privacyInformationIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            privacyInformationIconImageView.widthAnchor.constraint(equalToConstant: 16),
            privacyInformationIconImageView.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
}

// MARK: - ADXNativeAdRendering
extension ADXSampleNativeAdView: ADXNativeAdRendering {

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

    func nativePrivacyInformationIconImageView() -> UIImageView! {
        return self.privacyInformationIconImageView
    }
    
    func nativeMainImageView() -> UIImageView! {
        return self.mainImageView
    }
}
