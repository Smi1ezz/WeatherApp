//
//  DailySummaryViewController.swift
//  WeatherApp
//
//  Created by admin on 15.04.2022.
//

import UIKit

class DailySummaryViewController: UIViewController {

    var selectedDateIndex: Int = 0

    private var weather: WeatherModelDaily?

    private let dailySummaryTableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        dailySummaryTableView.delegate = self
        dailySummaryTableView.dataSource = self
        dailySummaryTableView.register(DateTableViewCell.self, forCellReuseIdentifier: "DateTableViewCell")
        dailySummaryTableView.register(DayTableViewCell.self, forCellReuseIdentifier: "DayTableViewCell")
        dailySummaryTableView.register(DayTableViewCell.self, forCellReuseIdentifier: "NightTableViewCell")
        dailySummaryTableView.register(SunAndMoonTableViewCell.self, forCellReuseIdentifier: "SunAndMoonTableViewCell")
        dailySummaryTableView.register(PressureTableViewCell.self, forCellReuseIdentifier: "AirTableViewCell")
        dailySummaryTableView.showsVerticalScrollIndicator = false
        dailySummaryTableView.showsHorizontalScrollIndicator = false
        view.addSubview(dailySummaryTableView)

        dailySummaryTableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(view.snp.right).offset(-15)
            make.bottom.equalTo(view.snp.bottom)
        }
    }

    func setWeather(_ weather: WeatherModelDaily) {
        self.weather = weather
    }

    private func setMaskLayer(toCell cell: UITableViewCell) {
        let verticalPadding: CGFloat = 12
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 5
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x,
                                 y: cell.bounds.origin.y,
                                 width: cell.bounds.width,
                                 height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
}

extension DailySummaryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weather = weather else {
            return UITableViewCell()
        }

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as! DateTableViewCell
            cell.setTableViewCell(delegate: self)
            cell.changeSelectedCollectionViewCell(to: selectedDateIndex)
            cell.setWeather(weather)
            setMaskLayer(toCell: cell)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell", for: indexPath) as! DayTableViewCell
            cell.setWeather(model: weather.dailyWeather[selectedDateIndex])
            cell.setState(to: .day)
            setMaskLayer(toCell: cell)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NightTableViewCell", for: indexPath) as! DayTableViewCell
            cell.setWeather(model: weather.dailyWeather[selectedDateIndex])
            cell.setState(to: .night)
            setMaskLayer(toCell: cell)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SunAndMoonTableViewCell", for: indexPath) as! SunAndMoonTableViewCell
            setMaskLayer(toCell: cell)
            cell.setWeather(model: weather.dailyWeather[selectedDateIndex])
            cell.setupCell()
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AirTableViewCell", for: indexPath) as! PressureTableViewCell
            setMaskLayer(toCell: cell)
            cell.setWeather(model: weather.dailyWeather[selectedDateIndex])
            cell.setupCell()
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

extension DailySummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0:
            let topOffset = 40
            let bottomOffset = 28
            let contentHeight = 36
            let rowHeight = topOffset + bottomOffset + contentHeight
            return CGFloat(rowHeight)
        case 1:
            let rowHeight = 341
            return CGFloat(rowHeight)
        case 2:
            let rowHeight = 341
            return CGFloat(rowHeight)
        case 3:
            let rowHeight = 161
            return CGFloat(rowHeight)
        case 4:
            let rowHeight = 160
            return CGFloat(rowHeight)
        default: return 0
        }
    }
}

extension DailySummaryViewController: DCVCDelegate {
    func changeSelectedDate(to index: Int) {
        selectedDateIndex = index
        self.reloadInputViews()
    }

    func reloadDataWithSelectedDate() {
        self.dailySummaryTableView.reloadData()
    }
}

extension DailySummaryViewController: DTVSDelegate {
    func reloadDataInTableView() {
        self.dailySummaryTableView.reloadData()
    }
}
