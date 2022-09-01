//
//  LocalWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by admin on 30.03.2022.
//

import UIKit

class LocalWeatherCollectionViewCell: UICollectionViewCell {

    private var weather: WeatherModelDaily?

    private weak var router: RouterProtocol?

    private let localWeatherScrollView = UIScrollView()

    private let shortInfoView: ShortInfoView = {
        let shortInfoView = ShortInfoView()
        return shortInfoView
    }()

    private let weatherForDayButton: UIButton = {
        let weatherForDayButton = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        let attrString = NSMutableAttributedString(string: "Подробнее на 24 часа", attributes: attributes)
        weatherForDayButton.setAttributedTitle(attrString, for: .normal)
        weatherForDayButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        return weatherForDayButton
    }()

    private let hoursCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let hourColView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        hourColView.showsHorizontalScrollIndicator = false
        return hourColView
    }()

    private let everyDayTableTitleView: EveryDayTableTitleView = {
        let everyDayTableTitleView = EveryDayTableTitleView()
        return everyDayTableTitleView
    }()

    private let everyDayWeatherTableView = UITableView(frame: .zero, style: .plain)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [shortInfoView, weatherForDayButton, hoursCollectionView, everyDayTableTitleView, everyDayWeatherTableView].forEach { item in
            localWeatherScrollView.addSubview(item)
        }

        hoursCollectionView.delegate = self
        hoursCollectionView.dataSource = self
        hoursCollectionView.register(HoursCollectionViewCell.self, forCellWithReuseIdentifier: "HoursCollectionViewCell")

        everyDayWeatherTableView.delegate = self
        everyDayWeatherTableView.dataSource = self
        everyDayWeatherTableView.register(EveryDayTableViewCell.self, forCellReuseIdentifier: "EveryDayTableViewCell")
        everyDayTableTitleView.setButtonTarget(self, action: #selector(setup7to25ButtonAction))

        weatherForDayButton.addTarget(self, action: #selector(setup24ButtonAction), for: .touchUpInside)

        contentView.addSubview(localWeatherScrollView)
    }

    func setCell(router: RouterProtocol) {
        self.router = router
    }

    func setupCellsSubviewsWithInfo(about weather: WeatherModelDaily) {
        shortInfoView.setupWithInfo(about: weather)
        self.weather = weather
        hoursCollectionView.reloadData()
        everyDayWeatherTableView.reloadData()
    }

    @objc
    func setup24ButtonAction(target: Any?, changeTime: Selector) {
        guard let weather = weather else {
            return
        }
        router?.showTwentyFourHoursVC(withWeather: weather)
    }

    @objc
    func setup7to25ButtonAction(target: Any?, changeDate: Selector) {
        // на 7 дней и на 25 дней - если найду такое API
    }

    private func setupConstraints() {

        localWeatherScrollView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)

        }

        // ширина экрана iphone13 375point. Исходя их этого получаем коэфициент сторон shortInfoView
        shortInfoView.snp.makeConstraints { make in
            let screenWidth = UIScreen.main.bounds.width
            make.top.equalTo(localWeatherScrollView.snp.top).offset(15)
            make.centerX.equalTo(localWeatherScrollView.snp.centerX)
            make.width.equalTo(screenWidth-30)
            make.height.equalTo((screenWidth-30)/(344/212))
        }

        weatherForDayButton.snp.makeConstraints { make in
            make.top.equalTo(shortInfoView.snp.bottom).offset(33)
            make.right.equalTo(shortInfoView.snp.right)
            make.height.equalTo(20)
        }

        hoursCollectionView.snp.makeConstraints { make in
            make.top.equalTo(weatherForDayButton.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(100)
        }

        everyDayTableTitleView.snp.makeConstraints { make in
            make.top.equalTo(hoursCollectionView.snp.bottom).offset(30)
            make.left.equalTo(shortInfoView.snp.left)
            make.right.equalTo(shortInfoView.snp.right)
            make.height.equalTo(22)
        }

        everyDayWeatherTableView.snp.makeConstraints { make in
            make.top.equalTo(everyDayTableTitleView.snp.bottom).offset(10)
            make.left.equalTo(shortInfoView.snp.left)
            make.right.equalTo(shortInfoView.snp.right)
            make.bottom.equalTo(localWeatherScrollView)
            make.height.greaterThanOrEqualTo((56*7)+(10*6)+10)
        }
    }
}

// MARK: CollectionView srttings
extension LocalWeatherCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let hours = 24
        return hours
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoursCollectionViewCell", for: indexPath) as! HoursCollectionViewCell
        guard let weather = weather else {
            return cell
        }
        cell.setDelegate(self)
        cell.setupWithInfo(about: weather, toHour: indexPath.item)
        return cell
    }

}

extension LocalWeatherCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 42, height: 83)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let weather = self.weather else { return }
        router?.showTwentyFourHoursVC(withWeather: weather)
    }

}

extension LocalWeatherCollectionViewCell: UICollectionViewDelegate {

}

// MARK: TableView srttings
extension LocalWeatherCollectionViewCell: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EveryDayTableViewCell", for: indexPath) as! EveryDayTableViewCell

        let verticalPadding: CGFloat = 10

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 5
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x,
                                 y: cell.bounds.origin.y,
                                 width: cell.bounds.width,
                                 height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer

        guard let weather = weather else {
            return cell
        }
        cell.setupWithInfo(about: weather.dailyWeather[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let weather = self.weather else {
            return
        }
        router?.showDailySummaryVC(withWeather: weather, selectedIndex: indexPath.row)
    }
}

extension LocalWeatherCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // высота ячейки по макету+верхний и нижний отступы
        let cellHeight: CGFloat = 56
        let designOffset: CGFloat = 10
        return cellHeight + designOffset
    }
}

extension LocalWeatherCollectionViewCell: HCVCDelegate {
    func selectCurrent(hour: Int) {
        let indexPath = IndexPath(item: hour, section: 0)
        self.hoursCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}
