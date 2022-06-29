//
//  AirTableViewCell.swift
//  WeatherApp
//
//  Created by admin on 15.04.2022.
//

import UIKit

class PressureTableViewCell: UITableViewCell {

    private weak var weather: TestDailyWeatherModel?

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Атмосферное давление"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel.textColor = .black
        return titleLabel
    }()

    private let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.text = "999"
        scoreLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        scoreLabel.textColor = .black
        return scoreLabel
    }()

    private let scoreDescriptionButton: UIButton = {
        let scoreDescriptionButton = UIButton()
        scoreDescriptionButton.setTitle("хорошо", for: .normal)
        scoreDescriptionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        scoreDescriptionButton.titleLabel?.textColor = .white
        scoreDescriptionButton.backgroundColor = UIColor.appColor(name: .appGreen)
        scoreDescriptionButton.layer.cornerRadius = 5
        scoreDescriptionButton.isUserInteractionEnabled = false
        return scoreDescriptionButton
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Качество воздуха считается удовлетворительным и загрязнения воздуха представляются незначительными в пределах нормы"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor.appColor(name: .appGrayForText)
        return descriptionLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [titleLabel, scoreLabel, scoreDescriptionButton, descriptionLabel].forEach { item in
            contentView.addSubview(item)
        }
        setupConstraints()
    }

    func setWeather(model weather: TestDailyWeatherModel) {
        self.weather = weather
    }

    func setupCell() {
        guard let weather = weather else {
            return
        }
        let pressure = weather.pressure

        scoreLabel.text = String(pressure)

        switch pressure {
        case 1000..<1030:
            scoreDescriptionButton.setTitle("нормальное", for: .normal)
        case 980..<1000:
            scoreDescriptionButton.setTitle("низкое", for: .normal)
        case ..<980:
            scoreDescriptionButton.setTitle("очень низкое", for: .normal)
        case 1030..<1050:
            scoreDescriptionButton.setTitle("высокое", for: .normal)
        default:
            scoreDescriptionButton.setTitle("очень высокое", for: .normal)
        }

    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.left.equalTo(contentView.snp.left)
            make.height.equalTo(22)

        }

        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left)
            make.height.equalTo(36)
        }

        scoreDescriptionButton.snp.makeConstraints { make in
            make.centerY.equalTo(scoreLabel.snp.centerY)
            make.left.equalTo(scoreLabel.snp.right).offset(15)
            make.width.equalTo(200)
            make.height.equalTo(26)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
    }
}
