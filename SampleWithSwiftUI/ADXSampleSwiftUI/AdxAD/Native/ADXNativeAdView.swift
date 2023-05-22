//
//  ADXNativeAdView.swift
//  ADXSampleSwiftUI
//
//  Created by JCLEE on 2023/05/18.
//

import SwiftUI
import ADXLibrary

struct ADXNativeAdView: UIViewControllerRepresentable {
    
    @Binding var isLoaded: Bool
    
    static let size:CGSize = CGSize(width: 320, height: 300)
    private let unitId:String = "6200fefc2a918d0001000009"
    private let nativeAdViewController = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ADXNativeAdFactory.sharedInstance().setRenderingViewClass(unitId, renderingViewClass: NativeAdView.self)
        ADXNativeAdFactory.sharedInstance().add(context.coordinator)
        ADXNativeAdFactory.sharedInstance().loadAd(unitId)
        return nativeAdViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        /// 구현 필요 없음.
    }
    
    // MARK: Coordinator.
    final class Coordinator: NSObject {
        var parent: ADXNativeAdView
        var nativeAd: ADXNativeAd?
        init(_ nativeView: ADXNativeAdView) {
            self.parent = nativeView
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension ADXNativeAdView.Coordinator: ADXNativeAdFactoryDelegate, ADXNativeAdDelegate {
    
    func onSuccess(_ adUnitId: String!, nativeAd: ADXNativeAd!) {
        guard let adView = ADXNativeAdFactory.sharedInstance().getNativeAdView(parent.unitId) else { return }
        adView.frame = CGRect(x: 0, y: 0, width: ADXNativeAdView.size.width, height: ADXNativeAdView.size.height)
        parent.isLoaded = adUnitId.caseInsensitiveCompare(parent.unitId) == .orderedSame
        if parent.isLoaded {
            self.nativeAd = nativeAd
            self.nativeAd?.delegate = self
            parent.nativeAdViewController.view.addSubview(adView)
        }
    }

    func onFailure(_ adUnitId: String!) {
        parent.isLoaded = false
    }
    
    // MARK: - ADXNativeAdDelegate
    func viewControllerForPresentingModalView() -> UIViewController {
        return parent.nativeAdViewController
    }
}

