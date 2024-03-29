//
//  sunAndMoonTableViewCell.swift
//  WeatherApp
//
//  Created by admin on 15.04.2022.
//

import UIKit

final class SunAndMoonTableViewCell: UITableViewCell {

    private var weather: DailyWeatherModel?

    private let sunAndMoonView = SunView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(sunAndMoonView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setWeather(model weather: DailyWeatherModel) {
        self.weather = weather
        setupCell()
    }

    private func setupCell() {
        guard let weather = weather else {
            return
        }
        sunAndMoonView.setupViewWith(weather: weather)
    }

    private func setupConstraints() {
        sunAndMoonView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

}
