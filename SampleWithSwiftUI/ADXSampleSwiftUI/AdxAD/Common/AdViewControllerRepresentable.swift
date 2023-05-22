//
//  AdViewControllerRepresentable.swift
//  ADXSampleSwiftUI
//
//  Created by JCLEE on 2023/05/17.
//

import UIKit
import SwiftUI

struct AdViewControllerRepresentable: UIViewControllerRepresentable {
    
    let viewController = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        /// 구현 필요 없음.
    }
}

@available(iOS 13.0, *)
struct AdViewController_Preview: PreviewProvider {
    static var previews: some View {
        AdViewControllerRepresentable()
    }
}
