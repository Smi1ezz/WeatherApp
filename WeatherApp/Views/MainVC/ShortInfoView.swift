//
//  ShortInfoView.swift
//  WeatherApp
//
//  Created by admin on 29.03.2022.
//

import UIKit

class ShortInfoView: UIView {

    private let dayNightImg: UIImageView = {
       let dayNightImg = UIImageView(image: UIImage(named: "Sun"))
       return dayNightImg
    }()

    private let descriptionLabel: UILabel = {
       let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        return descriptionLabel

    }()

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
         return dateLabel
    }()

    private let tempImg: UIImageView = {
       let tempImg = UIImageView(image: UIImage(named: "termHot"))
       return tempImg
    }()

    private let temperatureLabel: UILabel = {
       let tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .center
        return tempLabel
    }()

    private let windImg: UIImageView = {
       let windImg = UIImageView(image: UIImage(named: "wind"))
       return windImg
    }()

    private let windLabel: UILabel = {
       let windLabel = UILabel()
        windLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        windLabel.textColor = .white
        windLabel.textAlignment = .center
        return windLabel

    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.appColor(name: .appBlueBackground)
        self.layer.cornerRadius = 5
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWithInfo(about weather: WeatherModelDaily) {
        setupSubviews()

        dayNightImg.image = {
            if weather.currentWeather.dt < weather.currentWeather.sunset && weather.currentWeather.dt > weather.currentWeather.sunrise {
                return UIImage(named: "sun")
            } else {
                return UIImage(named: "moon")
            }
        }()

        descriptionLabel.text = weather.currentWeather.weather[0].description
        dateLabel.text = GlobalAppFormatter.shared.formateDate(fromUNIX: weather.currentWeather.dt, to: .dayDaySlashMounth)
        temperatureLabel.text = String(NSString(format: "%0.f", weather.currentWeather.temp)) + "°"
        windLabel.text = String(NSString(format: "%0.f", weather.currentWeather.windSpeed)) + "м/с"
    }

    private func setupSubviews() {
        [dayNightImg, dateLabel, tempImg, windImg, temperatureLabel, windLabel, descriptionLabel].forEach { item in
            self.addSubview(item)
        }

        setupConstraints()
    }

    private func setupConstraints() {
        dayNightImg.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dayNightImg.snp.bottom).offset(15)
            make.centerX.equalTo(dayNightImg.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }

        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dayNightImg.snp.top).offset(-15)
            make.centerX.equalTo(dayNightImg.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.right.equalTo(dayNightImg.snp.left).offset(-30)
            make.centerY.equalTo(dayNightImg.snp.centerY)
            make.height.equalTo(40)
        }

        tempImg.snp.makeConstraints { make in
            make.centerY.equalTo(temperatureLabel.snp.centerY)
            make.right.equalTo(temperatureLabel.snp.left).offset(-10)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }

        windImg.snp.makeConstraints { make in
            make.left.equalTo(dayNightImg.snp.right).offset(25)
            make.centerY.equalTo(dayNightImg.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(15)
        }

        windLabel.snp.makeConstraints { make in
            make.centerY.equalTo(windImg.snp.centerY)
            make.left.equalTo(windImg.snp.right).offset(10)
            make.height.equalTo(40)
        }

    }

}
