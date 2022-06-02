//
//  centerViewForDailyVC.swift
//  WeatherApp
//
//  Created by admin on 18.04.2022.
//

import UIKit

class CenterViewForDailyVC: UIView {
    let weatherImg: UIImageView = {
        let weatherImg = UIImageView(image: UIImage(named: "cloudRain"))
        weatherImg.contentMode = .scaleAspectFit
        return weatherImg
    }()

    let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "15°"
        temperatureLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        return temperatureLabel
    }()

    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Атмосферные осадки"
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return descriptionLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [weatherImg, descriptionLabel, temperatureLabel].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        weatherImg.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(30)
            make.height.equalTo(37)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(weatherImg.snp.right).offset(6)
            make.right.equalTo(self.snp.right)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
        }

    }

}
