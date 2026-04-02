import SwiftUI
import ADXLibrary

struct ADXNativeAdView: UIViewControllerRepresentable {
    
    @Binding var isLoaded: Bool
    
    static let size: CGSize = CGSize(width: 390.0, height: 250.0)
    private let unitId: String = "6200fefc2a918d0001000009"
    private let nativeAdViewController = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ADXNativeAdFactory.sharedInstance().setRenderingViewClass(unitId, renderingViewClass: ADXSampleNativeAdView.self)
        ADXNativeAdFactory.sharedInstance().add(context.coordinator)
        ADXNativeAdFactory.sharedInstance().loadAd(unitId)
        return nativeAdViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    // MARK: - Coordinator
    // UIGestureRecognizerDelegate 프로토콜 추가
    final class Coordinator: NSObject, ADXNativeAdFactoryDelegate, ADXNativeAdDelegate, UIGestureRecognizerDelegate {
        var parent: ADXNativeAdView
        var nativeAd: ADXNativeAd?
        
        init(_ nativeView: ADXNativeAdView) {
            self.parent = nativeView
        }
        
        // [방어 1] 탭이 발생한 순간 실행될 핵심 로직
        @objc func interceptTap() {
            // 현재 활성화된 Window 찾기 (iOS 15+ 권장 방식)
            let window = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
            
            if let validWindow = window, validWindow.isUserInteractionEnabled {
                print("[광고 탭 감지] 두 번째 클릭 증발을 위해 1.0초간 Window 잠금")
                
                // 화면 전체의 터치를 물리적으로 마비시킴
                validWindow.isUserInteractionEnabled = false
                
                // 1.0초 후(앱스토어가 뜨고 난 후) 다시 터치 복구
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

        func onSuccess(_ adUnitId: String!, nativeAd: ADXNativeAd!) {
            guard let adView = ADXNativeAdFactory.sharedInstance().getNativeAdView(parent.unitId) else { return }
            adView.frame = CGRect(x: 0, y: 0, width: ADXNativeAdView.size.width, height: ADXNativeAdView.size.height)
            adView.layoutIfNeeded()
            
            parent.isLoaded = adUnitId.caseInsensitiveCompare(parent.unitId) == .orderedSame
            
            if parent.isLoaded {
                self.nativeAd = nativeAd
                self.nativeAd?.delegate = self
                parent.nativeAdViewController.view.addSubview(adView)
                
                // [방어 3] 광고 뷰가 성공적으로 로드되면 스파이 제스처 부착
                let spyGesture = UITapGestureRecognizer(target: self, action: #selector(interceptTap))
                spyGesture.delegate = self
                spyGesture.cancelsTouchesInView = false // 중요: 기존 터치 이벤트를 훔치지 않고 그대로 흘려보냄
                adView.addGestureRecognizer(spyGesture)
            }
        }

        func onFailure(_ adUnitId: String!) {
            parent.isLoaded = false
        }
        
        func viewControllerForPresentingModalView() -> UIViewController {
            return parent.nativeAdViewController
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

