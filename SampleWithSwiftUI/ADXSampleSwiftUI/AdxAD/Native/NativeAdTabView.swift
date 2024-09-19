import SwiftUI

struct NativeAdTabView: View {
    
    @State var isLoaded: Bool = false
    
    var body: some View {
        
        VStack(alignment: .center) {
            ADXNativeAdView(isLoaded: $isLoaded)
                .frame(width: ADXNativeAdView.size.width, height: ADXNativeAdView.size.height)
            if !isLoaded {
                Text("광고 로딩 중").font(Font.headline).bold()
            }else {
                Spacer()
            }
        }
    }
}

struct NativeAdTabView_Previews: PreviewProvider {
    static var previews: some View {
        NativeAdTabView()
    }
}
