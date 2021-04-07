//
//  CustumLoading.swift
//  boozelee
//
//  Created by Sharvari-Amol on 22/08/19.
//  Copyright © 2019 AshwiniChoudhar. All rights reserved.
//

import UIKit

class CustumLoader: UIView {

    static let instance = CustumLoader()
    
    
    lazy var transparentView : UIView = {
        let transparentView = UIView(frame: UIScreen.main.bounds)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }()

    lazy var gifImage : UIImageView = {
        let gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        gifImage.contentMode = .scaleAspectFill
        gifImage.backgroundColor = UIColor.white//hexStringToUIColor(hex: "#FCEC31")
        gifImage.layer.cornerRadius = 5
        gifImage.layer.masksToBounds = false
        gifImage.clipsToBounds = true
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: "gifLoader")
        return gifImage
    }()
    
    func showLoader(){
        self.addSubview(transparentView)
        self.transparentView.addSubview(gifImage)
        self.transparentView.bringSubviewToFront(self.gifImage)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
    }
    
    func hideLoader(){
        self.transparentView.removeFromSuperview()
    }
    
}
