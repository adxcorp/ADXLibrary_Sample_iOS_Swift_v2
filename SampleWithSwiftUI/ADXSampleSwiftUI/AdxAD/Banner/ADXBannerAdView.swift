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
        
        // [방어] 중복 클릭 방지를 위한 스파이 제스처 부착
        let spyGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.interceptTap))
        spyGesture.delegate = context.coordinator
        spyGesture.cancelsTouchesInView = false
        bannerView.addGestureRecognizer(spyGesture)
        
        bannerView.loadAd()
        return bannerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        /// 구현 필요 없음.
    }
    
    // MARK: Coordinator
    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var parent: ADXBannerAdView
        init(_ bannerView: ADXBannerAdView) {
            self.parent = bannerView
        }
        
        // [방어 1] 탭이 발생한 순간 실행될 핵심 로직
        @objc func interceptTap() {
            let window = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
            
            if let validWindow = window, validWindow.isUserInteractionEnabled {
                print("[광고 탭 감지] 두 번째 클릭 증발을 위해 1.0초간 Window 잠금")
                validWindow.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    validWindow.isUserInteractionEnabled = true
                    print("[터치 복구] Window 잠금 해제")
                }
            }
        }
        
        // [방어 2] 우리의 스파이 제스처와 ADX SDK의 내부 제스처가 "동시에" 작동하도록 허용
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
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

