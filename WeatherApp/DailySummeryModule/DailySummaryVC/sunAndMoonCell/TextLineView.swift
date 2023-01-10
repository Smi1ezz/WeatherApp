//
//  TextLineView.swift
//  WeatherApp
//
//  Created by admin on 18.04.2022.
//

import UIKit

final class TextLineView: UIView {

    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Восход"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return descriptionLabel
    }()

    let valueLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "06:11"
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
        [descriptionLabel, valueLabel].forEach { item in
            self.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.left.equalTo(self.snp.left).offset(17)
        }

        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.right.equalTo(self.snp.right).offset(-5)
        }
    }
}
