//
//  TwentyFourHoursViewController.swift
//  WeatherApp
//
//  Created by admin on 14.04.2022.
//

import UIKit

class TwentyFourHoursViewController: UIViewController {

    private var weather: WeatherModelDaily?

    private var everyThreeHourWeather = [HourlyWeatherModel]()

    private let twentyFourTableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        twentyFourTableView.delegate = self
        twentyFourTableView.dataSource = self
        twentyFourTableView.register(TwentyFourHoursTableViewCell.self, forCellReuseIdentifier: "TwentyFourHoursTableViewCell")
        view.addSubview(twentyFourTableView)
        setupConstraints()
    }

    func setWeather(_ weather: WeatherModelDaily) {
        self.weather = weather

        var hoursCounter = 0
        for _ in 0...8 {
            everyThreeHourWeather.append(weather.hourlyWeather[hoursCounter])
            hoursCounter += 3
        }
    }

    private func setupConstraints() {
        twentyFourTableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

}

extension TwentyFourHoursViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let everyThreeHour = 9
        return everyThreeHour
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TwentyFourHoursTableViewCell", for: indexPath) as? TwentyFourHoursTableViewCell else {
            return UITableViewCell()
        }
        cell.setWeather(everyThreeHourWeather[indexPath.row])
        cell.setupCell()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }

}

extension TwentyFourHoursViewController: UITableViewDelegate {

}
