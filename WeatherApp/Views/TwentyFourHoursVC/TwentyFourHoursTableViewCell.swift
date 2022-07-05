//
//  TwentyFourHoursView.swift
//  WeatherApp
//
//  Created by admin on 14.04.2022.
//

import UIKit

class TwentyFourHoursTableViewCell: UITableViewCell {

    private var weather: HourlyWeatherModel?

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "пт 16/04"
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dateLabel.textColor = .black
        return dateLabel
    }()

    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "13:00"
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        timeLabel.textColor = UIColor.appColor(name: .appGrayForText)
        return timeLabel
    }()

    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "15°"
        temperatureLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        temperatureLabel.textColor = .black
        return temperatureLabel
    }()

    private let senseLineView = SituationLineView()

    private let windLineView = SituationLineView()

    private let rainFallView = SituationLineView()

    private let cloudyView = SituationLineView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.appColor(name: .appVioletBackground)
        setupSubviews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setWeather(_ weather: HourlyWeatherModel) {
        self.weather = weather
    }

    func setupCell() {
        guard let weather = weather else {
            return
        }

        let currentDate = weather.dt
        dateLabel.text = GlobalAppFormatter.shared.formateDate(fromUNIX: currentDate, to: .daySlashMounth)
        timeLabel.text = GlobalAppFormatter.shared.formateDate(fromUNIX: currentDate, to: .onlyTime24)
        temperatureLabel.text = String(NSString(format: "%0.f", weather.temp)) + "°"

        senseLineView.descriptionLabel.text = "По ощущениям"
        senseLineView.valueLabel.text = String(NSString(format: "%0.f", weather.feelsLike)) + "°"
        senseLineView.weatherImg.image = UIImage(named: "termHot")

        windLineView.descriptionLabel.text = "Ветер"
        windLineView.valueLabel.text = String(NSString(format: "%0.f", weather.windSpeed)) + "м/с"
        windLineView.weatherImg.image = UIImage(named: "wind")

        rainFallView.descriptionLabel.text = "Атмосферные осадки"
        rainFallView.valueLabel.text = String(NSString(format: "%0.f", (weather.pop*100))) + "%"
        rainFallView.weatherImg.image = UIImage(named: "rain")

        cloudyView.descriptionLabel.text = "Облачность"
        cloudyView.valueLabel.text = String(weather.clouds) + "%"
        cloudyView.weatherImg.image = UIImage(named: "cloudBlue")
    }

    private func setupSubviews() {
        [dateLabel, timeLabel, temperatureLabel, senseLineView, windLineView, rainFallView, cloudyView].forEach { item in
            contentView.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(contentView.snp.left).offset(15)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.left.equalTo(dateLabel.snp.left)
            make.width.equalTo(47)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left).offset(22)
        }

        senseLineView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.left.equalTo(timeLabel.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.height.equalTo(19)
        }

        windLineView.snp.makeConstraints { make in
            make.top.equalTo(senseLineView.snp.bottom).offset(8)
            make.left.equalTo(timeLabel.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.height.equalTo(19)
        }

        rainFallView.snp.makeConstraints { make in
            make.top.equalTo(windLineView.snp.bottom).offset(8)
            make.left.equalTo(timeLabel.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.height.equalTo(19)
        }

        cloudyView.snp.makeConstraints { make in
            make.top.equalTo(rainFallView.snp.bottom).offset(8)
            make.left.equalTo(timeLabel.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.height.equalTo(19)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }

    }

}
