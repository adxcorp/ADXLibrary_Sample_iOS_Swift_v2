//
//  ContentView.swift
//  ADXSampleSwiftUI
//
//  Created by JCLEE on 2023/05/17.
//

import SwiftUI

struct ContentView: View{
    
    var body: some View{
        
        TabView {
            
            RewardAdTabView().tabItem {
                Image(systemName: "1.square.fill")
                Text("보상광고").font(.headline)
            }
            
            InterstitialAdTabView().tabItem {
                Image(systemName: "2.square.fill")
                Text("전면광고").font(.headline)
            }
            
            BannerAdTabView().tabItem {
                Image(systemName: "3.square.fill")
                Text("배너광고").font(.headline)
            }
            
            NativeAdTabView().tabItem {
                Image(systemName: "4.square.fill")
                Text("네이티브광고").font(.headline)
            }
        }
    }
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor.lightGray
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}

