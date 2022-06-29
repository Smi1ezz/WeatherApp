//
//  LineViewForSettings.swift
//  WeatherApp
//
//  Created by admin on 19.04.2022.
//

// В этой версии SettingsVC не используется. Находится в стадии разработки и дополнения функционала

import UIKit

class LineViewForSettings: UIView {

    let toggleView: ToggleView = {
        let toggleView = ToggleView()
        return toggleView
    }()

    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Температура"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = UIColor.appColor(name: .appGrayForText)
        return descriptionLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.appColor(name: .appVioletBackground)
        setupSubviews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [descriptionLabel, toggleView].forEach { item in
            self.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        toggleView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(20)
        }
    }

}
