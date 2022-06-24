//
//  MainViewController.swift
//  WeatherApp
//
//  Created by admin on 29.03.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private var router: RouterProtocol?

    private var weatherStorageModel = WeatherInfoModel(netWorkManager: WeatherNetworkManager())

    private var locationsList = [Int]()

    private let locationPages: CustomPageControl = {
        let locationPages = CustomPageControl(frame: .zero)
        locationPages.isEnabled = false
        locationPages.pageIndicatorTintColor = UIColor.appColor(name: .appVioletBackground)
        locationPages.currentPageIndicatorTintColor = UIColor.black
        return locationPages
    }()

    private let addLocationButton: UIButton = {
        let addLocButton = UIButton()
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

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherStorageModel.fetchWeather()
        self.router = Router(withNaviVC: self.navigationController!)
        localWeatherCollectionView.register(LocalWeatherCollectionViewCell.self, forCellWithReuseIdentifier: "LocalWeatherCollectionViewCell")
        localWeatherCollectionView.delegate = self
        localWeatherCollectionView.dataSource = self

        weatherStorageModel.delegate = self
        locationPages.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavItem()
        setupSubviews()
        setupAddLocationButton()

    }

    func refreshData(withNewCity location: Location) {
        weatherStorageModel.addLocation(location)
        weatherStorageModel.fetchWeather()

    }

    private func setupSubviews() {
        let userData = UserDefaults.standard
        if userData.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue) {
            [locationPages, localWeatherCollectionView].forEach { item in
                view.addSubview(item)
                item.translatesAutoresizingMaskIntoConstraints = false
            }
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
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
                make.bottom.equalTo(localWeatherCollectionView.snp.top)
            }

            localWeatherCollectionView.snp.makeConstraints { make in
                make.top.equalTo(locationPages.snp.bottom)
                make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
        } else {
            addLocationButton.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(view.bounds.width/4)
                make.height.equalTo(view.bounds.width/4)
            }
        }
    }

    private func setupAddLocationButton() {
        addLocationButton.setBackgroundImage(UIImage(named: "addPng"), for: .normal)
        addLocationButton.addTarget(self, action: #selector(goToAddLocation), for: .touchUpInside)
    }

    private func setupNavItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(goToSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "location"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(goToAddLocation))
    }

    @objc
    func goToSettings() {
        // router show settings VC - функция настройки в разработке.
        // Сейчас это кнокпа сброса данных. Имитация первого запуска
        //        router?.showSettingsVC()

        print("данные приложения сброшены. Имитация первого запуска")
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.onboardingCompleted.rawValue)
        UserDefaults.standard.set(object: [Location](), forKey: UserDefaultsKeys.userLocations.rawValue)
        print("\(UserDefaults.standard.bool(forKey: UserDefaultsKeys.onboardingCompleted.rawValue))")
        print("\(UserDefaults.standard.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue))")
    }

    @objc
    func goToAddLocation() {
        router?.showAddCityAlertVC(onMainVC: self)
    }
}

extension MainViewController: UICollectionViewDelegate {

}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfLocations = weatherStorageModel.locations.count

        locationPages.numberOfPages = numberOfLocations
        return numberOfLocations
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocalWeatherCollectionViewCell", for: indexPath) as! LocalWeatherCollectionViewCell
        cell.setCell(router: router ?? Router())

        if !weatherStorageModel.storage.isEmpty {
            if !weatherStorageModel.storage[indexPath.section].isEmpty {
                let localWeather = weatherStorageModel.storage[indexPath.section][0]
                cell.setupCellsSubviewsWithInfo(about: localWeather)
                self.navigationItem.title = localWeather.timezone
                return cell
            }
        }
        return cell
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.height - 30)
    }
}

extension MainViewController: WeatherInfoDelegate {
    func refresh(model: WeatherInfoModelProtocol) {
        self.weatherStorageModel = model as! WeatherInfoModel
        localWeatherCollectionView.reloadData()
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
        if !weatherStorageModel.storage.isEmpty {
//            guard !weatherStorageModel.storage[locationPages.currentPage].isEmpty else {
//                return
//            }
            let localWeather = weatherStorageModel.storage[locationPages.currentPage][0]
            self.navigationItem.title = localWeather.timezone
        }
    }
}
