//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by admin on 19.04.2022.
//

// В этой версии SettingsVC не используется. Находится в стадии разработки и дополнения функционала

import UIKit

class SettingsViewController: UIViewController {

    private let backgroundView = BackgroundView()

    private let settingsView = SettingsView()

    override func viewWillLayoutSubviews() {
        view.backgroundColor = .blue
        setupSubviews()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

    }

    private func setupSubviews() {
        [backgroundView, settingsView].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
        settingsView.setDoneButton(target: self, action: #selector(saveAndExit))

    }

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        settingsView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(320)
            make.height.equalTo(330)
        }
    }

    @objc
    func saveAndExit() {
        print("сохранить и выйти на главный")
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }

}
