//
//  ToggleView.swift
//  WeatherApp
//
//  Created by admin on 19.04.2022.
//

// В этой версии SettingsVC не используется. Находится в стадии разработки и дополнения функционала

import UIKit

class ToggleView: UIView {

    let firstButton: UIButton = {
        let firstButton = UIButton(type: .system)
        firstButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        firstButton.setTitleColor(.white, for: .normal)
//        firstButton.backgroundColor = UIColor.appColor(name: .appBlueForToggle)
        return firstButton
    }()

    let secondButton: UIButton = {
        let secondButton = UIButton(type: .system)
        secondButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        secondButton.setTitleColor(.black, for: .normal)
//        secondButton.backgroundColor = .white
        return secondButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func firstButtonSelected() {
        firstButton.setTitleColor(.white, for: .normal)
        firstButton.backgroundColor = UIColor.appColor(name: .appBlueForToggle)
        secondButton.setTitleColor(.black, for: .normal)
        secondButton.backgroundColor = .white
    }

    func secondButtonSelected() {
        firstButton.setTitleColor(.black, for: .normal)
        firstButton.backgroundColor = .white
        secondButton.setTitleColor(.white, for: .normal)
        secondButton.backgroundColor = UIColor.appColor(name: .appBlueForToggle)
    }

    private func setupSubviews() {
        [firstButton, secondButton].forEach { item in
            self.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
        }

        secondButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.centerX)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
