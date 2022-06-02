//
//  sunAndMoonTableViewCell.swift
//  WeatherApp
//
//  Created by admin on 15.04.2022.
//

import UIKit

class SunAndMoonTableViewCell: UITableViewCell {

    private weak var weather: TestDailyWeatherModel?

    private let sunAndMoonView = SunView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sunAndMoonView.translatesAutoresizingMaskIntoConstraints = false
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

    func setWeather(model weather: TestDailyWeatherModel) {
        self.weather = weather
    }

    func setupCell() {
        guard let weather = weather else {
            return
        }
        sunAndMoonView.setupViewWith(weather: weather)
    }

    private func setupConstraints() {
        sunAndMoonView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }

}
