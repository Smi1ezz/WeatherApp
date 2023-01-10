//
//  DailySummaryViewController.swift
//  WeatherApp
//
//  Created by admin on 15.04.2022.
//

import UIKit

final class DailySummaryViewController: UIViewController {
    private let presenter: DailyPresenterProtocol

    private let dailySummaryTableView = UITableView(frame: .zero, style: .plain)

    init(presenter: DailyPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
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
        setupConstraints()
    }

    private func setupConstraints() {
        dailySummaryTableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(view.snp.right).offset(-15)
        }
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

    // swiftlint:disable:next cyclomatic_complexity
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = presenter.weather
        let selectedDateIndex = presenter.selecterIndex

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as? DateTableViewCell else {
                return UITableViewCell()
            }
            cell.setTableViewCell(delegate: self)
            cell.changeSelectedCollectionViewCell(to: selectedDateIndex)
            cell.setWeather(weather)
            setMaskLayer(toCell: cell)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell", for: indexPath) as? DayTableViewCell else {
                return UITableViewCell()
            }
            cell.setWeather(model: weather.dailyWeather[selectedDateIndex])
            cell.setState(to: .day)
            setMaskLayer(toCell: cell)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NightTableViewCell", for: indexPath) as? DayTableViewCell else {
                return UITableViewCell()
            }
            cell.setWeather(model: weather.dailyWeather[selectedDateIndex])
            cell.setState(to: .night)
            setMaskLayer(toCell: cell)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SunAndMoonTableViewCell", for: indexPath) as? SunAndMoonTableViewCell else {
                return UITableViewCell()
            }
            setMaskLayer(toCell: cell)
            cell.setWeather(model: weather.dailyWeather[selectedDateIndex])
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AirTableViewCell", for: indexPath) as? PressureTableViewCell else {
                return UITableViewCell()
            }
            setMaskLayer(toCell: cell)
            cell.setWeather(model: weather.dailyWeather[selectedDateIndex])
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
//        selectedDateIndex = index
        presenter.newIndex(index)
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
