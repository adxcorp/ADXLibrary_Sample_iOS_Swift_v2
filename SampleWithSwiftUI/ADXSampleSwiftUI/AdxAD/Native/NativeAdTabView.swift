import SwiftUI

struct NativeAdTabView: View {
    @State private var isLoaded: Bool = false
    @ObservedObject private var sdkManager = ADXSdkStatusManager.shared
    
    var body: some View {
        List {
            ForEach(0..<20) { index in
                if index == 2 {
                    Button {
                        print("터치 이벤트")
                    } label: {
                        nativeAdCell
                    }
                } else {
                    normalContentCell(for: index)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var nativeAdCell: some View {
        VStack(alignment: .center) {
            if sdkManager.isInitialized {
                ADXNativeAdView(isLoaded: $isLoaded)
                    .frame(width: ADXNativeAdView.size.width,
                           height: ADXNativeAdView.size.height)
            } else {
                Text("ADX SDK 초기화 대기 중...")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(height: ADXNativeAdView.size.height)
            }
            
            if sdkManager.isInitialized && !isLoaded {
                Text("광고 로딩 중...")
                    .font(.headline)
                    .bold()
                    .frame(height: 100)
            }
        }
        .frame(maxWidth: .infinity)
        .listRowInsets(EdgeInsets())
    }
    
    private func normalContentCell(for index: Int) -> some View {
        Text("일반 콘텐츠 \(index + 1)")
            .padding()
            .onTapGesture {
                print("👉 일반 콘텐츠 \(index + 1) 클릭됨")
            }
    }
}
