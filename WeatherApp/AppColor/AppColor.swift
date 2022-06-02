//
//  AppColor.swift
//  WeatherApp
//
//  Created by admin on 04.04.2022.
//

import Foundation
import UIKit

enum AppColors {
    case appOrange, appGrayForText, appVioletBackground, appBlueBackground, appGreen, appBlueForToggle
}

extension UIColor {

    static func appColor(name: AppColors) -> UIColor {
        switch name {
        case .appOrange:
            return UIColor(named: "appOrange") ?? .orange
        case .appGrayForText:
            return UIColor(named: "appGrayForText") ?? .systemGray
        case .appVioletBackground:
            return UIColor(named: "appVioletBackground") ?? .blue
        case .appBlueBackground:
            return UIColor(named: "appBlueBackground") ?? .blue
        case .appGreen:
            return UIColor(named: "appGreen") ?? .green
        case .appBlueForToggle:
            return UIColor(named: "appBlueForToggle") ?? .blue

        }
    }
}
