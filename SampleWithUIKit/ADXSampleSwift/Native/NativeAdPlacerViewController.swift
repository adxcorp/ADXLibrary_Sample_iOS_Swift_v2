//
//  NativeAdPlacerViewController.swift
//  ADXSampleSwift
//
//  Copyright © 2017 AD(X) Corp. All rights reserved.
//

import UIKit
import ADXLibrary

class NativeAdPlacerViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var placer : ADXCollectionViewAdPlacer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ADXNativeAdFactory.sharedInstance().setRenderingViewClass(ADX_NATIVE_AD_UNIT_ID, renderingViewClass: NativeAdView.self)
        
        let adPositioning = ADXAdPositioning()
        adPositioning.addFixedIndexPath(IndexPath(row: 0, section: 0))
        adPositioning.enableRepeatingPositions(withInterval: 3)
        
        self.placer = ADXNativeAdFactory.sharedInstance().getCollectionViewAdPlacer(ADX_NATIVE_AD_UNIT_ID, collectionView: collectionView, viewController: self, adPositioning: adPositioning)
        self.placer.loadAds(forAdUnitID: ADX_NATIVE_AD_UNIT_ID)
    }
}

extension NativeAdPlacerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.adx_dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! UICollectionViewCell
        
        return cell
    }
    
}
