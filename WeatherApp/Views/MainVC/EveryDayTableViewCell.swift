//
//  EveryDayTableViewCell.swift
//  WeatherApp
//
//  Created by admin on 08.04.2022.
//

import UIKit

class EveryDayTableViewCell: UITableViewCell {

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "17/04"
        dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return dateLabel
    }()

    private let humidityLabel: UILabel = {
        let wetnessLabel = UILabel()
        wetnessLabel.text = "57%"
        wetnessLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)

        return wetnessLabel
    }()

    private let weatherImg: UIImageView = {
        let weatherImg = UIImageView(image: UIImage(named: "cloudRain"))
        weatherImg.contentMode = .scaleAspectFit
        return weatherImg
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Преимущественно облачно"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        return descriptionLabel
    }()

    private let tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "14-15°"
        tempLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        tempLabel.adjustsFontSizeToFitWidth = true

        return tempLabel
    }()

    private let arrowImg: UIImageView = {
        let arrowImg = UIImageView(image: UIImage(named: "arrowImg"))
        return arrowImg
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addBorders(edges: [.bottom], color: UIColor.appColor(name: .appBlueBackground), inset: 16, thickness: 0.5)
        contentView.backgroundColor = UIColor.appColor(name: .appVioletBackground)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWithInfo(about weather: TestDailyWeatherModel) {
        dateLabel.text = GlobalAppFormatter.shared.formateDate(fromUNIX: weather.dt, to: .daySlashMounth)
        humidityLabel.text = "\(weather.humidity)%"
        descriptionLabel.text = weather.weather[0].description
        tempLabel.text = {
            guard let min = weather.temp.min, let max = weather.temp.max else { return "99"}
            let minTemp = NSString(format: "%.0f", min)
            let maxTemp = NSString(format: "%.0f", max)
            return "\(minTemp)°-\(maxTemp)°"
        }()
        weatherImg.image = UIImage(named: weather.weather[0].icon)
    }

    private func setupSubviews() {
        [dateLabel, weatherImg, humidityLabel, descriptionLabel, tempLabel, arrowImg].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(item)
        }
    }

    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(6+5) // offset+1/2padding
            make.left.equalTo(contentView.snp.left).offset(10)
            make.width.equalTo(53)
            make.height.equalTo(19)
        }

        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(6)
            make.left.equalTo(contentView.snp.left).offset(30)
            make.height.equalTo(15.19)
        }

        weatherImg.snp.makeConstraints { make in
            make.centerY.equalTo(humidityLabel.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(206)
            make.left.equalTo(dateLabel.snp.right).offset(3)
            make.right.equalTo(tempLabel.snp.left).offset(-3)
        }

        tempLabel.snp.makeConstraints { make in
            make.right.equalTo(arrowImg.snp.left).offset(-10)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        arrowImg.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(6)
            make.height.equalTo(9.49)
        }
    }

}
