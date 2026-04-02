import SwiftUI
import ADXLibrary

class ADXSdkStatusManager: ObservableObject {
    
    @Published var isInitialized: Bool = ADXSdk.sharedInstance().isInitialized
    
    static let shared = ADXSdkStatusManager()
    
    private init() {
        if !isInitialized {
            checkStatus()
        }
    }
    
    func checkStatus() {
        if ADXSdk.sharedInstance().isInitialized {
            isInitialized = true
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.checkStatus()
        }
    }
}
