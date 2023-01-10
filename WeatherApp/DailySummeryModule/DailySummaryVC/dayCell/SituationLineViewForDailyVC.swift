//
//  SituationLineViewForDailyVC.swift
//  WeatherApp
//
//  Created by admin on 18.04.2022.
//

import UIKit

final class SituationLineViewForDailyVC: UIView {

    let weatherImg: UIImageView = {
        let weatherImg = UIImageView(image: UIImage(named: "cloudRain"))
        weatherImg.contentMode = .scaleAspectFit
        return weatherImg
    }()

    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Атмосферные осадки"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return descriptionLabel
    }()

    let valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.text = "2 m/s CCЗ"
        valueLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        valueLabel.textColor = UIColor.appColor(name: .appGrayForText)
        return valueLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [weatherImg, descriptionLabel, valueLabel].forEach { self.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        weatherImg.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(25)
            make.height.equalTo(25)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(weatherImg.snp.right).offset(15)
        }

        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.snp.right).offset(-15)
        }
    }

}
