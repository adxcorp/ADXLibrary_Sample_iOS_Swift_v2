import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard scene is UIWindowScene else { return }
        // UIKit creates the window and root view controller from Main.storyboard.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 수동 ATT 요청이 필요한 경우 AppDelegate.requestTrackingPermission(completion:)을 호출합니다.
        // 애드몹 UMP의 IDFA 메시지를 통한 ATT 동의 요청을 권장합니다.
        // https://docs.adxcorp.kr/appendix/ump-user-messaging-platform
    }
}
