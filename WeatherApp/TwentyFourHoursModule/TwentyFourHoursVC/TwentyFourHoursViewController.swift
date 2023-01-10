//
//  TwentyFourHoursViewController.swift
//  WeatherApp
//
//  Created by admin on 14.04.2022.
//

import UIKit

final class TwentyFourHoursViewController: UIViewController {

    private let presenter: TwentyHourPresenterProtocol

    private let twentyFourTableView = UITableView(frame: .zero, style: .plain)

    init(presenter: TwentyHourPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        twentyFourTableView.delegate = self
        twentyFourTableView.dataSource = self
        twentyFourTableView.register(TwentyFourHoursTableViewCell.self, forCellReuseIdentifier: "TwentyFourHoursTableViewCell")
        view.addSubview(twentyFourTableView)
        setupConstraints()
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
        let weatherStorage = presenter.everyThreeHourWeather
        cell.setWeather(weatherStorage[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}

extension TwentyFourHoursViewController: UITableViewDelegate {

}
