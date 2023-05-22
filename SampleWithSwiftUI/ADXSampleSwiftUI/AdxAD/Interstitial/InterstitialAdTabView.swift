//
//  InterstitialAdView.swift
//  ADXSampleSwiftUI
//
//  Created by JCLEE on 2023/05/17.
//

import SwiftUI
import ADXLibrary

struct InterstitialAdTabView: View {
    /// 전면 광고 로드 및 표시 위한  클래스
    @ObservedObject private var adCoordinator = InterstialAdCoordinator()
    
    /// 컨텐츠 화면
    var body: some View {
        
        VStack {
            Button("전면광고 보기") {
                adCoordinator.presentAd()
            }.frame(width: 150, height: 50)            
        }
        .onAppear {
            adCoordinator.loadAd()
        }
        .disabled(!adCoordinator.isLoaded)
        
    }
}

struct InterstitialAdView_Previews: PreviewProvider {
    static var previews: some View {
        InterstitialAdTabView()
    }
}

