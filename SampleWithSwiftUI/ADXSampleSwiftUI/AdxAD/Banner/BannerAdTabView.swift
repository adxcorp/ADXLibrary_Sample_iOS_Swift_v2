//
//  BannerAdTabView.swift
//  ADXSampleSwiftUI
//
//  Created by JCLEE on 2023/05/18.
//

import SwiftUI

struct BannerAdTabView: View {
    
    @State var isLoaded: Bool = false
    
    var body: some View {
        
        VStack(alignment: .center) {
            ADXBannerAdView(isLoaded: $isLoaded)
                .frame(width: ADXBannerAdView.size.width, height: ADXBannerAdView.size.height)
            if !isLoaded {
                Text("광고 로딩 중").font(Font.headline).bold()
            }else {
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
