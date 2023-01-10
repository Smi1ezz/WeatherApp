//
//  OnboardingView.swift
//  WeatherApp
//
//  Created by admin on 05.04.2022.
//

import UIKit

final class OnboardingView: UIScrollView {
    private let pocketLabel: UILabel = {
        let pocketLabel = UILabel()
        pocketLabel.textAlignment = .left
        pocketLabel.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        pocketLabel.textColor = UIColor.appColor(name: .appOrange)
        pocketLabel.numberOfLines = 0
        pocketLabel.text = "Pocket"
        return pocketLabel
    }()

    private let umbrellaLabel: UILabel = {
        let pocketLabel = UILabel()
        pocketLabel.textAlignment = .left
        pocketLabel.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        pocketLabel.textColor = .white
        pocketLabel.numberOfLines = 0
        pocketLabel.text = "Umbrella"
        return pocketLabel
    }()

    private let onboardingImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "pogodaOnboardingPNG"))
        return img
    }()

    private let bigDescriptionLabel: UILabel = {
        let description = UILabel()
        description.textAlignment = .left
        description.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        description.textColor = .white
        description.numberOfLines = 0
        description.text =
"""
Разрешить приложению  Weather
использовать данные
о местоположении вашего устройства
"""
        return description
    }()

    private let smallDescriptionLabel: UILabel = {
       let description = UILabel()
        description.textAlignment = .left
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.textColor = .white
        description.numberOfLines = 0
        description.text =
"""
Чтобы получить более точные прогнозы погоды
во время движения или путешествия

Вы можете изменить свой выбор в любое
время из меню приложения
"""
        return description
    }()

    private let agreeButton: UIButton = {
        let agreeButton = UIButton()
        return agreeButton
    }()

    private let disagreeButton: UIButton = {
       let disagreeButton = UIButton()
        return disagreeButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [pocketLabel, umbrellaLabel, smallDescriptionLabel, bigDescriptionLabel, agreeButton, disagreeButton, onboardingImg].forEach { self.addSubview($0) }

        setupAgreeButton()
        setupDisagreeButton()
    }

    private func setupAgreeButton() {
        agreeButton.backgroundColor = UIColor.appColor(name: .appOrange)
        agreeButton.layer.cornerRadius = 10
        agreeButton.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        agreeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        agreeButton.setTitleColor(.white, for: .normal)
        agreeButton.titleLabel?.textAlignment = .center

    }

    private func setupDisagreeButton() {
        disagreeButton.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        disagreeButton.setTitleColor(.white, for: .normal)
        disagreeButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        disagreeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)

    }

    private func setupConstraints() {

        let view = self

        onboardingImg.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(UIScreen.main.bounds.height/4)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo((UIScreen.main.bounds.width) * 0.563)
            make.centerX.equalTo(view.snp.centerX)
        }

        umbrellaLabel.snp.makeConstraints { make in
            make.left.equalTo(view.snp.centerX).offset(-55)
            make.bottom.equalTo(onboardingImg.snp.top).offset(-15)
        }

        pocketLabel.snp.makeConstraints { make in
            make.right.equalTo(view.snp.centerX)
            make.bottom.equalTo(umbrellaLabel.snp.top).offset(-10)
        }

        bigDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingImg.snp.bottom).offset(30)
            make.width.equalTo(UIScreen.main.bounds.width - 36)
            make.centerX.equalTo(view.snp.centerX)
        }

        smallDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(bigDescriptionLabel.snp.bottom).offset(30)
            make.width.equalTo(UIScreen.main.bounds.width - 36)
            make.centerX.equalTo(view.snp.centerX)
        }

        agreeButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(smallDescriptionLabel.snp.bottom).offset(40)
            make.width.equalTo(UIScreen.main.bounds.width - 36)
            make.centerX.equalTo(view.snp.centerX)
        }
        disagreeButton.snp.makeConstraints { make in
            make.height.equalTo(21)
            make.top.equalTo(agreeButton.snp.bottom).offset(25)
            make.width.equalTo(UIScreen.main.bounds.width - 36)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }

    }

    func setButtonsActions(target: Any?, agree: Selector, disagree: Selector) {
        agreeButton.addTarget(target, action: agree, for: .touchUpInside)
        disagreeButton.addTarget(target, action: disagree, for: .touchUpInside)
    }

}
