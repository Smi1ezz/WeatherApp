//
//  HoursCollectionViewCell.swift
//  WeatherApp
//
//  Created by admin on 08.04.2022.
//

import UIKit

protocol HCVCDelegate: AnyObject {
    func selectCurrent(hour: Int)
}

final class HoursCollectionViewCell: UICollectionViewCell {
    private weak var delegate: HCVCDelegate?

    private let hourLabel: UILabel = {
       let hourLabel = UILabel()
        hourLabel.text = "12:00"
        hourLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        hourLabel.textColor = UIColor.appColor(name: .appGrayForText)
        return hourLabel
    }()

    private let weatherImage: UIImageView = {
        let weatherImage = UIImageView(image: UIImage(named: "sun.max.fill"))
        weatherImage.contentMode = .scaleAspectFit

        return weatherImage
    }()

    private let temperatureLabel: UILabel = {
       let temperatureLabel = UILabel()
        temperatureLabel.text = "13°"
        return temperatureLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.appColor(name: .appVioletBackground)
        self.layer.cornerRadius = 22

        self.layer.shadowColor = UIColor.appColor(name: .appVioletBackground).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDelegate(_ delegate: HCVCDelegate) {
        self.delegate = delegate
    }

    func setupWithInfo(about weather: WeatherModelDaily, toHour: Int) {
        hourLabel.text = {
            let unixDate = weather.hourlyWeather[toHour].dt
            if GlobalAppFormatter.shared.isEquelDates(now: Date(), unixDate: unixDate) == true {
                delegate?.selectCurrent(hour: toHour)
            }
            let strDate = GlobalAppFormatter.shared.formateDate(fromUNIX: unixDate, to: .onlyTime24)
            return strDate
        }()

        temperatureLabel.text = {
            let temperatureNow = weather.hourlyWeather[toHour].temp
            let formatedTemperature = NSString(format: "%.0f", temperatureNow)
            return "\(formatedTemperature)°"
        }()

        weatherImage.image = UIImage(named: weather.hourlyWeather[toHour].weather[0].icon)
    }

    private func setupSubviews() {
        [hourLabel, temperatureLabel, weatherImage].forEach { item in
            contentView.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {

        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(18)
        }

        weatherImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).offset(-7)
            make.height.equalTo(18)
        }
    }

    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.appColor(name: .appBlueBackground) : UIColor.appColor(name: .appVioletBackground)
            self.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.appColor(name: .appBlueBackground).cgColor
            self.layer.shadowColor = isSelected ? UIColor.appColor(name: .appBlueBackground).cgColor : UIColor.appColor(name: .appVioletBackground).cgColor

            self.temperatureLabel.textColor =  isSelected ? .white : .black
            self.hourLabel.textColor = isSelected ? .white : UIColor.appColor(name: .appGrayForText)
        }
    }

}
