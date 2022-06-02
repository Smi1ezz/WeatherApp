//
//  ImgLineView.swift
//  WeatherApp
//
//  Created by admin on 18.04.2022.
//

import UIKit

class ImgLineView: UIView {

    let weatherImg: UIImageView = {
        let weatherImg = UIImageView(image: UIImage(named: "sun"))
        weatherImg.contentMode = .scaleAspectFit
        return weatherImg
    }()

    let valueLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "" // в api нет длительности светового дня, поискать
        temperatureLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return temperatureLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [weatherImg, valueLabel].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        weatherImg.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.left.equalTo(self.snp.left).offset(17)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.right.equalTo(self.snp.right).offset(-5)
        }

    }

}
