//
//  SettingsView.swift
//  WeatherApp
//
//  Created by admin on 19.04.2022.
//

// В этой версии SettingsVC не используется. Находится в стадии разработки и дополнения функционала

import UIKit

class SettingsView: UIView {

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Настройки"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.textColor = .black
        return titleLabel
    }()

    private let temperatureLineView: LineViewForSettings = {
        let temperatureLineView = LineViewForSettings()
        temperatureLineView.descriptionLabel.text = "Температура"
        temperatureLineView.toggleView.firstButton.setTitle("C", for: .normal)
        temperatureLineView.toggleView.secondButton.setTitle("F", for: .normal)
        temperatureLineView.toggleView.firstButtonSelected()
        return temperatureLineView
    }()

    private let windSpeedLineView: LineViewForSettings = {
        let windSpeedLineView = LineViewForSettings()
        windSpeedLineView.descriptionLabel.text = "Скорость ветра"
        windSpeedLineView.toggleView.firstButton.setTitle("Mi", for: .normal)
        windSpeedLineView.toggleView.secondButton.setTitle("Km", for: .normal)
        windSpeedLineView.toggleView.firstButtonSelected()
        return windSpeedLineView
    }()

    private let timeFormatLineView: LineViewForSettings = {
        let timeFormatLineView = LineViewForSettings()
        timeFormatLineView.descriptionLabel.text = "Формат времени"
        timeFormatLineView.toggleView.firstButton.setTitle("12", for: .normal)
        timeFormatLineView.toggleView.secondButton.setTitle("24", for: .normal)
        timeFormatLineView.toggleView.secondButtonSelected()
        return timeFormatLineView
    }()

    private let notificationLineView: LineViewForSettings = {
        let notificationLineView = LineViewForSettings()
        notificationLineView.descriptionLabel.text = "Уведомления"
        notificationLineView.toggleView.firstButton.setTitle("On", for: .normal)
        notificationLineView.toggleView.secondButton.setTitle("Off", for: .normal)
        notificationLineView.toggleView.firstButtonSelected()
        return notificationLineView
    }()

    private let doneButton: UIButton = {
        let doneButton = UIButton(type: .system)
        doneButton.backgroundColor = UIColor.appColor(name: .appOrange)
        doneButton.layer.cornerRadius = 10
        doneButton.setTitle("Установить", for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        doneButton.setTitleColor(UIColor.appColor(name: .appVioletBackground), for: .normal)
        return doneButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.appColor(name: .appVioletBackground)
        setupSubviews()
        setupTogglesActions()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: функц для установки параметров(уже сохранены в юзердефолтс в функциях тогглов) и перехода на главный экран. Назначается в сеттингс контроллере, потомучто там есть навигейшн. Кстати, может быть через роутор этого и не нужно???
    func setDoneButton(target: Any?, action: Selector) {
        doneButton.addTarget(target, action: action, for: .touchUpInside)
    }

    @objc
    func changeTemperatureToC() {
        self.temperatureLineView.toggleView.firstButtonSelected()
//        let userData = UserDefaults.standard
//        userData.set(true, forKey: UserDefaultsKeys.temperatureCelsius.rawValue)
        print("change to C")
    }

    @objc
    func changeTemperatureToF() {
        self.temperatureLineView.toggleView.secondButtonSelected()
//        let userData = UserDefaults.standard
//        userData.set(false, forKey: UserDefaultsKeys.temperatureCelsius.rawValue)
        print("change to F")

    }

    @objc
    func changeSpeedToMi() {
        self.temperatureLineView.toggleView.firstButtonSelected()
        let userData = UserDefaults.standard
        userData.set(true, forKey: UserDefaultsKeys.speedMi.rawValue)
    }

    @objc
    func changeSpeedToKm() {
        self.temperatureLineView.toggleView.secondButtonSelected()
        let userData = UserDefaults.standard
        userData.set(false, forKey: UserDefaultsKeys.speedMi.rawValue)
    }

    @objc
    func changeTimeToTwelveHours() {
        self.temperatureLineView.toggleView.firstButtonSelected()
        let userData = UserDefaults.standard
        userData.set(false, forKey: UserDefaultsKeys.timeTwentyFourHours.rawValue)
    }

    @objc
    func changeTimeToTwentyFourHours() {
        self.temperatureLineView.toggleView.secondButtonSelected()
        let userData = UserDefaults.standard
        userData.set(true, forKey: UserDefaultsKeys.timeTwentyFourHours.rawValue)
    }

    @objc
    func changeNotificationsOn() {
        self.temperatureLineView.toggleView.firstButtonSelected()
        let userData = UserDefaults.standard
        userData.set(true, forKey: UserDefaultsKeys.notificationsOn.rawValue)
    }

    @objc
    func changeNotificationsOff() {
        self.temperatureLineView.toggleView.secondButtonSelected()
        let userData = UserDefaults.standard
        userData.set(false, forKey: UserDefaultsKeys.notificationsOn.rawValue)
    }

    private func setupTogglesActions() {
        temperatureLineView.toggleView.firstButton.addTarget(self, action: #selector(changeTemperatureToC), for: .touchUpInside)
        temperatureLineView.toggleView.secondButton.addTarget(self, action: #selector(changeTemperatureToF), for: .touchUpInside)
        windSpeedLineView.toggleView.firstButton.addTarget(self, action: #selector(changeSpeedToMi), for: .touchUpInside)
        windSpeedLineView.toggleView.secondButton.addTarget(self, action: #selector(changeSpeedToKm), for: .touchUpInside)
        timeFormatLineView.toggleView.firstButton.addTarget(self, action: #selector(changeTimeToTwelveHours), for: .touchUpInside)
        timeFormatLineView.toggleView.secondButton.addTarget(self, action: #selector(changeTimeToTwentyFourHours), for: .touchUpInside)
        notificationLineView.toggleView.firstButton.addTarget(self, action: #selector(changeNotificationsOn), for: .touchUpInside)
        notificationLineView.toggleView.secondButton.addTarget(self, action: #selector(changeNotificationsOff), for: .touchUpInside)
    }

    private func setupSubviews() {
        [titleLabel, temperatureLineView, windSpeedLineView, timeFormatLineView, notificationLineView, doneButton].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(27)
            make.left.equalTo(self.snp.left).offset(20)
            make.height.equalTo(15)
        }

        temperatureLineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left).offset(20)
            make.width.equalTo(270)
            make.height.equalTo(30)
        }

        windSpeedLineView.snp.makeConstraints { make in
            make.top.equalTo(temperatureLineView.snp.bottom).offset(20)
            make.left.equalTo(self.snp.left).offset(20)
            make.width.equalTo(270)
            make.height.equalTo(30)
        }

        timeFormatLineView.snp.makeConstraints { make in
            make.top.equalTo(windSpeedLineView.snp.bottom).offset(20)
            make.left.equalTo(self.snp.left).offset(20)
            make.width.equalTo(270)
            make.height.equalTo(30)
        }

        notificationLineView.snp.makeConstraints { make in
            make.top.equalTo(timeFormatLineView.snp.bottom).offset(20)
            make.left.equalTo(self.snp.left).offset(20)
            make.width.equalTo(270)
            make.height.equalTo(30)
        }

        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
    }

}
