import UIKit
import StoreKit
import ObjectiveC

// MARK: - UIViewController+StoreKitGuard
extension UIViewController {

    // MARK: - Install

    /// 앱 시작 시 한 번만 호출, 이후 모든 UIViewController.present() 호출을 가로채어
    /// SKStoreProductViewController가 동시에 2개 이상 열리는 것을 차단
    static func installStoreKitGuard() {
        _ = _once
    }

    private static let _once: Void = {
        guard
            let original = class_getInstanceMethod(UIViewController.self,
                                                   #selector(UIViewController.present(_:animated:completion:))),
            let swizzled = class_getInstanceMethod(UIViewController.self,
                                                   #selector(UIViewController._guarded_present(_:animated:completion:)))
        else {
            print("[StoreKitGuard] Swizzle 실패")
            return
        }
        method_exchangeImplementations(original, swizzled)
        print("[StoreKitGuard] Swizzle 설치 완료")
    }()

    // MARK: - Active VC Tracking
    /// 현재 화면에 노출 중인 SKStoreProductViewController를 약한 참조로 추적
    /// presentingViewController == nil 이면 이미 닫힌 것으로 판단
    private static weak var _activeStoreVC: SKStoreProductViewController?

    // MARK: - Swizzled present
    @objc private func _guarded_present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        if let incoming = viewControllerToPresent as? SKStoreProductViewController {
            // 이미 활성 storeVC가 있고 아직 presenting 중이면 차단
            if let active = UIViewController._activeStoreVC,
               active.presentingViewController != nil {
                print("[StoreKitGuard] SKStoreProductViewController 이미 노출 중 → 두 번째 present 전역 차단")
                return
            }
            // 약한 참조로 추적 시작 (닫히면 자동으로 nil이 됨)
            UIViewController._activeStoreVC = incoming
            print("[StoreKitGuard] SKStoreProductViewController 최초 present 허용")
        }

        // 스위즐로 인해 실제로는 원래 present(_:animated:completion:) 호출
        self._guarded_present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
