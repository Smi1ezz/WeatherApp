//
//  MainViewController.swift
//  WeatherApp
//
//  Created by admin on 29.03.2022.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    private var mainWeatherPresenter: MainWeatherPresenterProtocol

    private let locationPages: CustomPageControl = {
        let locationPages = CustomPageControl(frame: .zero)
        locationPages.isEnabled = false
        locationPages.pageIndicatorTintColor = UIColor.appColor(name: .appVioletBackground)
        locationPages.currentPageIndicatorTintColor = UIColor.black
        return locationPages
    }()

    private let addLocationButton: UIButton = {
        let addLocButton = UIButton()
        addLocButton.setBackgroundImage(UIImage(named: "addPng"), for: .normal)
        return addLocButton
    }()

    private let localWeatherCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        let localWeatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        localWeatherCollectionView.showsHorizontalScrollIndicator = false
        localWeatherCollectionView.isPagingEnabled = true
        return localWeatherCollectionView
    }()

    private let spinner = UIActivityIndicatorView(style: .medium)

    init(presenter: MainWeatherPresenterProtocol) {
        self.mainWeatherPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainWeatherPresenter.setPresented(viewController: self)
        localWeatherCollectionView.register(LocalWeatherCollectionViewCell.self,
                                            forCellWithReuseIdentifier: "LocalWeatherCollectionViewCell")
        localWeatherCollectionView.delegate = self
        localWeatherCollectionView.dataSource = self
        locationPages.delegate = self

        setupNavItemBarButtons()
        setupSubviews()
        setupAddLocationButtonTarget()

        mainWeatherPresenter.fetchWeather()
    }

    private func setupSubviews() {
        let userData = UserDefaults.standard
        if userData.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue) {
            [locationPages, localWeatherCollectionView].forEach { view.addSubview($0) }
            setupConstraints()
        } else {
            view.addSubview(addLocationButton)
            view.backgroundColor = .white
            setupConstraints()
        }
    }

    private func setupConstraints() {
        let userData = UserDefaults.standard
        if userData.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue) {
            locationPages.snp.makeConstraints { make in
                make.top.left.right.equalTo(view.safeAreaLayoutGuide)
                make.height.equalTo(26)
            }

            localWeatherCollectionView.snp.makeConstraints { make in
                make.top.equalTo(locationPages.snp.bottom)
                make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        } else {
            addLocationButton.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.width.equalTo(view.bounds.width/4)
                make.height.equalTo(view.bounds.width/4)
            }
        }
    }

    private func setupAddLocationButtonTarget() {
        addLocationButton.addTarget(self, action: #selector(goToAddLocation), for: .touchUpInside)
    }

    private func setupNavItemBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(reset))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "location"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(goToAddLocation))
    }

    @objc
    func reset() {
        print("данные приложения сброшены. Имитация первого запуска")
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.onboardingCompleted.rawValue)
        UserDefaults.standard.set(object: [Location](), forKey: UserDefaultsKeys.userLocations.rawValue)
        print("\(UserDefaults.standard.bool(forKey: UserDefaultsKeys.onboardingCompleted.rawValue))")
        print("\(UserDefaults.standard.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue))")
    }

    @objc
    func goToAddLocation() {
        let alertVC = UIAlertController(title: "Добавить город",
                                        message: "введите название города на английском или русском языке.",
                                        preferredStyle: .alert)

        alertVC.addTextField(configurationHandler: { $0.placeholder = "City..." })

        alertVC.addAction(UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: {[weak self] _ in

            guard let name = alertVC.textFields?.first?.text, !name.isEmpty else {
                return
            }

            self?.mainWeatherPresenter.fetchLocation(ofCity: name, complition: { [weak self] in
                self?.setupSubviews()
            })

        }))

        alertVC.addAction(UIAlertAction(title: "Отмена",
                                        style: .cancel,
                                        handler: nil))

        present(alertVC, animated: true)
    }
}

extension MainViewController: MainWeatherPresenterDelegate {
    func reload() {
        localWeatherCollectionView.reloadData()
    }

    func startSpinner() {
        spinner.startAnimating()
        spinner.color = .appColor(name: .appBlueForToggle)
        view.addSubview(spinner)
        spinner.center = view.center
    }

    func stopSpinner() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }

    func showWarning(error: String) {
        let alertVC = UIAlertController(title: "Ошибка подключения",
                                        message: "ошибка \(error). проверьте подключение к интернету и перезагрузите приложение",
                                        preferredStyle: .alert)

        alertVC.addAction(UIAlertAction(title: "Ок",
                                        style: .cancel,
                                        handler: nil))

        present(alertVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate {

}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfModels = mainWeatherPresenter.storage?.count ?? 0
        locationPages.numberOfPages = numberOfModels
        return numberOfModels
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocalWeatherCollectionViewCell", for: indexPath) as? LocalWeatherCollectionViewCell else {
            return UICollectionViewCell()
        }

        guard let storage = mainWeatherPresenter.storage,
              let localWeather = storage[indexPath.section].first else {
            return cell
        }
        cell.setCell(coordinator: mainWeatherPresenter.coordinator)
        cell.setupCellsSubviewsWithInfo(about: localWeather)
        self.navigationItem.title = localWeather.timezone
        return cell
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.height - 30)
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        locationPages.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        locationPages.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

 }

extension MainViewController: PageControllDelegate {
    func changeNaviTitle() {
        guard let storage = mainWeatherPresenter.storage,
              let localWeather = storage[locationPages.currentPage].first else {
            return
        }
        self.navigationItem.title = localWeather.timezone
    }
}
