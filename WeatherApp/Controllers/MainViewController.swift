//
//  MainViewController.swift
//  WeatherApp
//
//  Created by admin on 29.03.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private var router: RouterProtocol

    private var weatherStorageModel: WeatherInfoModelProtocol

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

    init(router: RouterProtocol, model: WeatherInfoModelProtocol) {
        self.weatherStorageModel = model
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        localWeatherCollectionView.register(LocalWeatherCollectionViewCell.self, forCellWithReuseIdentifier: "LocalWeatherCollectionViewCell")
        localWeatherCollectionView.delegate = self
        localWeatherCollectionView.dataSource = self
        locationPages.delegate = self
        refrashAllData()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavItem()
        setupSubviews()
        setupAddLocationButton()
    }

    func refrashAllData() {
        guard weatherStorageModel.locations.isEmpty else {
            for location in weatherStorageModel.locations {
                self.featchWeatherFromModel(aboutCity: location)
            }
            return
        }

        weatherStorageModel.fetchFirstLocation { [weak self] firstLocation in
            self?.featchWeatherFromModel(aboutCity: firstLocation)
        }
    }

    func refrashDataOf(newLocation: Localizable) {
        guard let location = newLocation as? Location else {
            return
        }
        weatherStorageModel.addLocation(location)

        self.featchWeatherFromModel(aboutCity: location)
    }

    func correctLocationsInModes() {
        weatherStorageModel.locations = []
        for item in weatherStorageModel.storage {
            let lon = item[0].longitude
            let lat = item[0].latitude
            let location = Location(latitude: lat, longitude: lon)
            weatherStorageModel.addLocation(location)
        }
    }

    private func featchWeatherFromModel(aboutCity city: Localizable) {
        weatherStorageModel.fetchWeather(inCity: city) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    print("localWeatherCollectionView перерисовывается")
                    self?.localWeatherCollectionView.reloadData()
                }
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }

    private func setupSubviews() {
        let userData = UserDefaults.standard
        if userData.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue) {
            [locationPages, localWeatherCollectionView].forEach { item in
                view.addSubview(item)
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

        print("данные приложения сброшены. Имитация первого запуска")
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.onboardingCompleted.rawValue)
        UserDefaults.standard.set(object: [Location](), forKey: UserDefaultsKeys.userLocations.rawValue)
        print("\(UserDefaults.standard.bool(forKey: UserDefaultsKeys.onboardingCompleted.rawValue))")
        print("\(UserDefaults.standard.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue))")
    }

    @objc
    func goToAddLocation() {
        router.showAddCityAlertVC(onMainVC: self)
    }
}

extension MainViewController: UICollectionViewDelegate {

}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfModels = weatherStorageModel.storage.count

        locationPages.numberOfPages = numberOfModels
        return numberOfModels
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocalWeatherCollectionViewCell", for: indexPath) as! LocalWeatherCollectionViewCell
        cell.setCell(router: router)

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
            let localWeather = weatherStorageModel.storage[locationPages.currentPage][0]
            self.navigationItem.title = localWeather.timezone
        }
    }
}
