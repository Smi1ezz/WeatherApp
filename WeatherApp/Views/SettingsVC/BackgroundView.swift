//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by admin on 19.04.2022.
//

// В этой версии SettingsVC не используется. Находится в стадии разработки и дополнения функционала

import UIKit

class BackgroundView: UIView {

    private let firstCloud: UIImageView = {
        let firstCloud = UIImageView(image: UIImage(named: "cloudHi"))
        firstCloud.alpha = 0.33
        firstCloud.contentMode = .scaleAspectFit
        return firstCloud
    }()

    private let secondCloud: UIImageView = {
        let secondCloud = UIImageView(image: UIImage(named: "cloudMid"))
        secondCloud.contentMode = .scaleAspectFit
        return secondCloud
    }()

    private let thirdCloud: UIImageView = {
        let thirdCloud = UIImageView(image: UIImage(named: "cloudLo"))
        thirdCloud.contentMode = .scaleAspectFit
        return thirdCloud
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.appColor(name: .appBlueBackground)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [firstCloud, secondCloud, thirdCloud].forEach { item in
            self.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        firstCloud.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(37)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(245.4)
            make.height.equalTo(58.1)
        }

        secondCloud.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(121)
            make.right.equalTo(self.snp.right)
            make.width.equalTo(180)
            make.height.equalTo(94.2)
        }

        thirdCloud.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-94.9)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(216.8)
            make.height.equalTo(65.1)
        }
    }

}
