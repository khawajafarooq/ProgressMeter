//
//  ThemeColor.swift
//  ProgressMeter
//
//  Created by khawajafarooq on 11/22/17.
//  Copyright © 2017 Xmen. All rights reserved.
//

import UIKit

public enum AppColor {
    
    case blue
    case gray
    case graySeparator
    
    var rgba: [CGFloat] {
        switch self {
        case .blue: return [118.0 / 255.0, 214.0 / 255.0, 255.0 / 255.0, 1.0]
        case .gray: return [235.0 / 255.0, 235.0 / 255.0, 235.0 / 255.0, 1.0]
        case .graySeparator: return [169.0 / 255.0, 169.0 / 255.0, 169.0 / 255.0, 1.0]
        }
    }
    
    var r: CGFloat { return self.rgba[0] }
    var g: CGFloat { return self.rgba[1] }
    var b: CGFloat { return self.rgba[2] }
    var a: CGFloat { return self.rgba[3] }
    
}

// MARK: - UIColor extension
extension UIColor {
    
    convenience init(appColor: AppColor) {
        self.init(red: appColor.r, green: appColor.g, blue: appColor.b, alpha: appColor.a)
    }
}



