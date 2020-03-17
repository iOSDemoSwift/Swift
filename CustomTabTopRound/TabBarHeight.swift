//
//  TabBarHeight.swift
//  APITabDemo
//
//  Created by Piyush Chodvadiya on 17/03/20.
//  Copyright © 2020 Asd. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarHeight : UITabBar {

@IBInspectable var height: CGFloat = 65.0

override open func sizeThatFits(_ size: CGSize) -> CGSize {
    guard let window = UIApplication.shared.keyWindow else {
        return super.sizeThatFits(size)
    }
    var sizeThatFits = super.sizeThatFits(size)
    if height > 0.0 {

        if #available(iOS 11.0, *) {
            sizeThatFits.height = height + window.safeAreaInsets.bottom
        } else {
            sizeThatFits.height = height
        }
    }
    return sizeThatFits
    }
}
