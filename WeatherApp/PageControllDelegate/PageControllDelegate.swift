//
//  PageControllDelegate.swift
//  WeatherApp
//
//  Created by admin on 25.05.2022.
//

import Foundation
import UIKit

protocol PageControllDelegate: AnyObject {
    func changeNaviTitle()
}

class CustomPageControl: UIPageControl {
    weak var delegate: PageControllDelegate?

    override var currentPage: Int {
        didSet {
            delegate?.changeNaviTitle()
        }
    }
}
