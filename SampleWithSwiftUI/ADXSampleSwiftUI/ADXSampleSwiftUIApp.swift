import SwiftUI
import ADXLibrary
import FBAudienceNetwork
import AppTrackingTransparency

class RunCodeOnce {
    var already: Bool = false
    func run(block: () -> Void) {
        guard !already else { return }
        block()
        already = true
    }
}

@main
struct ADXSampleSwiftUIApp: App {
    
    private static let appID:String = "6200fea42a918d0001000001"
    private let once = RunCodeOnce()
    
    init() {
        UIViewController.installStoreKitGuard()
    }

    var body: some Scene {
        WindowGroup {
            ContentView().onReceive(
                NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    once.run {
                        #if targetEnvironment(simulator)
                        #else
                        initializeAdSDK()
                        #endif
                    }
                }
        }
    }
}

extension ADXSampleSwiftUIApp {
    
    func initializeAdSDK() {
        DispatchQueue.global().async {
            let configuration = ADXConfiguration(appId: ADXSampleSwiftUIApp.appID, gdprType: .popupLocation)
            ADXSdk.sharedInstance().initialize(with: configuration) { result, consentState in
                print("ADX SDK Initialize: \(result)")
                // 프로그래밍 방식으로 수동으로  ATT (App Tracking Transparency) 동의 요청 할 경우에만, 아래 코드를 사용.
                // requestIDFA()
                
                // 애드몹 UMP (User Messaging Platform)의 IDFA 메시지를 통한 ATT (App Tracking Transparency) 동의 요청 권장
                // 참조 링크: https://docs.adxcorp.kr/appendix/ump-user-messaging-platform
            }
        }
    }
    
    func requestTrackingPermission(completion: @escaping (Bool) -> Void) {
        guard #available(iOS 14, *) else {
            return DispatchQueue.main.async { completion(true) }
        }
        let currentStatus = ATTrackingManager.trackingAuthorizationStatus
        if currentStatus == .authorized {
            return DispatchQueue.main.async { completion(true) }
        } else if currentStatus == .denied || currentStatus == .restricted {
            return DispatchQueue.main.async { completion(false) }
        }
        
        func request() {
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async { completion(status == .authorized) }
            }
        }
        if UIApplication.shared.applicationState == .active {
            request()
            return
        }
        var observer: NSObjectProtocol?
        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { _ in
            if let obs = observer {
                NotificationCenter.default.removeObserver(obs)
                observer = nil
                request()
            }
        }
    }
    
}
