import SwiftUI
import ADXLibrary

struct ADXBannerAdView: UIViewControllerRepresentable {
    
    @Binding var isLoaded: Bool
    static let size:CGSize = CGSize(width: 320, height: 50)
    private let unitId:String = "6200fee42a918d0001000003"
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let bannerViewController = UIViewController()
        let bannerView = ADXAdView(adUnitId: unitId,
                                   adSize: ADXBannerAdView.size,
                                   rootViewController: bannerViewController)
        
        bannerView.delegate = context.coordinator
        bannerView.rootViewController = bannerViewController
        bannerViewController.view.addSubview(bannerView)
        bannerView.loadAd()
        return bannerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        /// 구현 필요 없음.
    }
    
    // MARK: Coordinator
    final class Coordinator: NSObject {
        var parent: ADXBannerAdView
        init(_ bannerView: ADXBannerAdView) {
            self.parent = bannerView
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension ADXBannerAdView.Coordinator: ADXAdViewDelegate {
    
    func adViewDidLoad(_ adView: ADXAdView) {
        print("adViewDidLoad");
        parent.isLoaded = true
    }
    
    func adView(_ adView: ADXAdView, didFailToLoadWithError error: Error) {
        print("didFailToLoadWithError")
        parent.isLoaded = false
    }
    
    func adViewDidClick(_ adView: ADXAdView) {
        print("adViewDidClick")
    }
}
