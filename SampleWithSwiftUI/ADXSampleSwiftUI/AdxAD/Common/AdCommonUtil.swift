//
//  AdCommonUtil.swift
//  ADXSampleSwiftUI
//
//  Created by JCLEE on 2023/05/18.
//

import UIKit

final class AdCommonUtil {
    
    static func getRootViewController() -> UIViewController? {
        var rootViewController:UIViewController? = nil
        if #available(iOS 15, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            rootViewController = window?.rootViewController
        }
        if rootViewController != nil {
            return rootViewController
        }
        return UIApplication.shared.windows.first?.rootViewController
    }
}


