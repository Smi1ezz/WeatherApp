//
//  DateCollectionViewCell.swift
//  WeatherApp
//
//  Created by admin on 15.04.2022.
//

import UIKit

protocol DCVCDelegate: AnyObject {
    func changeSelectedDate(to index: Int)
    func reloadDataWithSelectedDate()
}

final class DateCollectionViewCell: UICollectionViewCell {

    private var index: Int?
    private var weather: WeatherModelDaily?

    private weak var delegate: DCVCDelegate?

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "16/04 ПТ"
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return dateLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        dateLabel.textColor = UIColor.black
        contentView.addSubview(dateLabel)
        contentView.layer.cornerRadius = 5
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setWeather(_ weather: WeatherModelDaily) {
        self.weather = weather
        setupCell()
    }

    func changeIndexTo(_ newIndex: Int) {
        self.index = newIndex
    }

    func setCollectionViewCell(delegate: DCVCDelegate?) {
        self.delegate = delegate
    }

    private func setupCell() {
        guard let weather = weather, let index = index else {
            return
        }

        let date = weather.dailyWeather[index].dt
        dateLabel.text = GlobalAppFormatter.shared.formateDate(fromUNIX: date, to: .daySlashMounth)
    }

    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(76)
            make.height.equalTo(22)
            make.center.equalToSuperview()
        }
    }

    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? UIColor.blue : UIColor.white
            dateLabel.textColor = isSelected ? UIColor.white : UIColor.black
            guard let index = index else { return }
            delegate?.changeSelectedDate(to: index)
        }
    }
}
