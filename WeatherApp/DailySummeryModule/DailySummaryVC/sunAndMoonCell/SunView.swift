//
//  SunView.swift
//  WeatherApp
//
//  Created by admin on 18.04.2022.
//

import UIKit

final class SunView: UIView {
    private let titleLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Солнце и луна"
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return descriptionLabel
    }()

    private let sunImgLine = ImgLineView()

    private let sunDawnTextLine = TextLineView()

    private let sunDuskTextLine = TextLineView()

    private let moonImgLine = ImgLineView()

    private let moonDawnTextLine = TextLineView()

    private let moonDuskTextLine = TextLineView()

    private let centerBorderLine: UIView = {
        let centerBorderLine = UIView(frame: .zero)
        centerBorderLine.backgroundColor = UIColor.appColor(name: .appBlueBackground)
        return centerBorderLine
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewWith(weather: DailyWeatherModel) {
        sunDawnTextLine.valueLabel.text = GlobalAppFormatter.shared.formateDate(fromUNIX: weather.sunrise, to: .onlyTime24)
        sunDuskTextLine.valueLabel.text = GlobalAppFormatter.shared.formateDate(fromUNIX: weather.sunset, to: .onlyTime24)
        sunDuskTextLine.descriptionLabel.text = "Закат"

        moonImgLine.weatherImg.image = UIImage(named: "moon")
        moonDawnTextLine.valueLabel.text = GlobalAppFormatter.shared.formateDate(fromUNIX: weather.moonset, to: .onlyTime24)
        moonDuskTextLine.valueLabel.text = GlobalAppFormatter.shared.formateDate(fromUNIX: weather.moonrise, to: .onlyTime24)
        moonDuskTextLine.descriptionLabel.text = "Закат"

    }

    private func setupSubviews() {
        [titleLabel, sunImgLine, sunDawnTextLine, sunDuskTextLine, moonImgLine, moonDawnTextLine, moonDuskTextLine, centerBorderLine].forEach { self.addSubview($0) }

        sunDawnTextLine.addBorders(edges: [.top, .bottom],
                                   color: UIColor.appColor(name: .appBlueBackground),
                                   inset: 0,
                                   thickness: 0.5)
        moonDawnTextLine.addBorders(edges: [.top, .bottom],
                                    color: UIColor.appColor(name: .appBlueBackground),
                                    inset: 0,
                                    thickness: 0.5)
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.left.equalTo(self.snp.left)
        }

        centerBorderLine.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-12)
            make.width.equalTo(0.5)
            make.height.equalTo(100)
        }

        sunImgLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(160)
            make.height.equalTo(36)
        }

        sunDawnTextLine.snp.makeConstraints { make in
            make.top.equalTo(sunImgLine.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(160)
            make.height.equalTo(36)
        }

        sunDuskTextLine.snp.makeConstraints { make in
            make.top.equalTo(sunDawnTextLine.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(160)
            make.height.equalTo(36)
        }

        moonImgLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.right.equalTo(self.snp.right)
            make.width.equalTo(160)
            make.height.equalTo(36)
        }

        moonDawnTextLine.snp.makeConstraints { make in
            make.top.equalTo(moonImgLine.snp.bottom)
            make.right.equalTo(self.snp.right)
            make.width.equalTo(160)
            make.height.equalTo(36)
        }

        moonDuskTextLine.snp.makeConstraints { make in
            make.top.equalTo(moonDawnTextLine.snp.bottom)
            make.right.equalTo(self.snp.right)
            make.width.equalTo(160)
            make.height.equalTo(36)
        }

    }

}
