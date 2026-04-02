import SwiftUI

struct BannerAdTabView: View {
    
    @State var isLoaded: Bool = false
    @ObservedObject private var sdkManager = ADXSdkStatusManager.shared
    
    var body: some View {
        
        VStack(alignment: .center) {
            if sdkManager.isInitialized {
                ADXBannerAdView(isLoaded: $isLoaded)
                    .frame(width: ADXBannerAdView.size.width, height: ADXBannerAdView.size.height)
            } else {
                Text("ADX SDK 초기화 대기 중...")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(height: ADXBannerAdView.size.height)
            }
            
            if sdkManager.isInitialized && !isLoaded {
                Text("광고 로딩 중").font(Font.headline).bold()
            } else if isLoaded {
                Spacer()
            }
        }
    }
}

struct BannerAdView_Previews: PreviewProvider {
    static var previews: some View {
        BannerAdTabView()
    }
}
