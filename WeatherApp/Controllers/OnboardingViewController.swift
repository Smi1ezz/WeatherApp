//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by admin on 01.04.2022.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    private let router: RouterProtocol

    private let scrollView = OnboardingView()

    init(router: RouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillLayoutSubviews() {
        view.backgroundColor = .blue
        setupSubviews()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.setButtonsActions(target: self, agree: #selector(agreeAction), disagree: #selector(disagreeAction))
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    @objc
    func agreeAction() {
        let userData = UserDefaults.standard
        userData.set(true, forKey: UserDefaultsKeys.onboardingCompleted.rawValue)
        userData.set(true, forKey: UserDefaultsKeys.locationAvailible.rawValue)
        router.showMainVC()
    }

    @objc
    func disagreeAction() {
        let userData = UserDefaults.standard
        userData.set(true, forKey: UserDefaultsKeys.onboardingCompleted.rawValue)
        userData.set(false, forKey: UserDefaultsKeys.locationAvailible.rawValue)
        router.showMainVC()
    }

}
