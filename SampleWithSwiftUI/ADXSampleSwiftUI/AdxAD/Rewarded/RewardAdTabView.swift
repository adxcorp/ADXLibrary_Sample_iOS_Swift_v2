import SwiftUI
import ADXLibrary

struct RewardAdTabView: View {
    /// 보상 광고 로드 및 표시 위한  클래스
    @ObservedObject private var adCoordinator = RewardAdCoordinator()
    
    /// 컨텐츠 화면
    var body: some View {
        
        VStack {
            Button("보상광고 로드") {
                adCoordinator.loadAd()
            }
            .disabled(adCoordinator.isLoaded)
            .frame(width: 150, height: 50)
            
            Button("보상광고 보기") {
                adCoordinator.presentAd()
            }
            .disabled(!adCoordinator.isLoaded)
            .frame(width: 150, height: 50)
        }
    }
}

struct RewardAdView_Previews: PreviewProvider {
    static var previews: some View {
        RewardAdTabView()
    }
}

