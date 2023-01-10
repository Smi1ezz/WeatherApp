//
//  SituationLineView.swift
//  WeatherApp
//
//  Created by admin on 15.04.2022.
//

import UIKit

final class SituationLineView: UIView {

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
        [weatherImg, descriptionLabel, valueLabel].forEach { item in
            self.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        weatherImg.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(12)
            make.height.equalTo(12)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(weatherImg.snp.right).offset(4)
        }

        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

}
