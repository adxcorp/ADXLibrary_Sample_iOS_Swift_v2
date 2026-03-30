import SwiftUI

struct NativeAdTabView: View {
    
    @State private var isLoaded: Bool = false
    
    var body: some View {
        List {
            ForEach(0..<20) { index in
                if index == 2 {
                    nativeAdCell
                } else {
                    normalContentCell(for: index)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var nativeAdCell: some View {
        VStack(alignment: .center) {
            ADXNativeAdView(isLoaded: $isLoaded)
                .frame(width: ADXNativeAdView.size.width,
                       height: ADXNativeAdView.size.height)
            
            if !isLoaded {
                Text("광고 로딩 중")
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

struct NativeAdTabView_Previews: PreviewProvider {
    static var previews: some View {
        NativeAdTabView()
    }
}
