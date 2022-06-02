//
//  dayTableViewCell.swift
//  WeatherApp
//
//  Created by admin on 15.04.2022.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    enum State {
        case day, night
    }

    private weak var weather: TestDailyWeatherModel?

    private var state: State = .day

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return titleLabel
    }()

    private let centerView = CenterViewForDailyVC()

    private let senseLineView = SituationLineViewForDailyVC()

    private let windLineView = SituationLineViewForDailyVC()

    private let ufLineView = SituationLineViewForDailyVC()

    private let rainFallView = SituationLineViewForDailyVC()

    private let cloudyView = SituationLineViewForDailyVC()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.appColor(name: .appVioletBackground)
        self.isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupSubviews() {
        [titleLabel, centerView, senseLineView, windLineView, ufLineView, rainFallView, cloudyView].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(item)
        }
        [senseLineView, windLineView, ufLineView, rainFallView, cloudyView].forEach { item in
            item.addBorders(edges: [.bottom], color: UIColor.appColor(name: .appBlueBackground), inset: 0, thickness: 0.5)
        }
        setupConstraints()

        guard state == .night else {
            setupDayState()
            return
        }
        setupNightState()

    }

    func setState(to state: State) {
        self.state = state
        setupSubviews()
    }

    func setWeather(model weather: TestDailyWeatherModel) {
        self.weather = weather
    }

    func setupDayState() {
        self.titleLabel.text = "День"

        let temperature = NSString(format: "%.0f", (weather?.temp.day ?? 99))
        centerView.temperatureLabel.text = "\(temperature)°"
        centerView.descriptionLabel.text = weather?.weather[0].main
        centerView.weatherImg.image = UIImage(named: "\(weather?.weather[0].icon ?? "sun")")

        senseLineView.descriptionLabel.text = "По ощущениям"
        let senseTemperature = NSString(format: "%.0f", (weather?.feelsLike.day ?? 99))
        senseLineView.valueLabel.text = "\(senseTemperature)°"
        senseLineView.weatherImg.image = UIImage(named: "termHot")

        windLineView.descriptionLabel.text = "Ветер"
        let windSpeed = NSString(format: "%.0f", (weather?.windSpeed ?? 99))
        windLineView.valueLabel.text = "\(windSpeed)"
        windLineView.weatherImg.image = UIImage(named: "wind")

        ufLineView.descriptionLabel.text = "УФ-излучение"
        let ufIndex = NSString(format: "%.0f", (weather?.uvi ?? 99))
        ufLineView.valueLabel.text = "\(ufIndex)"
        ufLineView.weatherImg.image = UIImage(named: "sun")

        rainFallView.descriptionLabel.text = "Дождь"
        let rainy = NSString(format: "%.0f", ((weather?.pop ?? 99) * 100))
        rainFallView.valueLabel.text = "\(rainy)%"
        rainFallView.weatherImg.image = UIImage(named: "cloudRain")

        cloudyView.descriptionLabel.text = "Облачность"
        cloudyView.valueLabel.text = "\(weather?.clouds ?? 99)%"
        cloudyView.weatherImg.image = UIImage(named: "cloudBlue")
    }

    func setupNightState() {
        self.titleLabel.text = "Ночь"

        let temperature = NSString(format: "%.0f", (weather?.temp.eve ?? 99))
        centerView.temperatureLabel.text = "\(temperature)°"
        centerView.descriptionLabel.text = weather?.weather[0].main
        centerView.weatherImg.image = UIImage(named: "\(weather?.weather[0].icon ?? "sun")")

        senseLineView.descriptionLabel.text = "По ощущениям"
        let senseTemperature = NSString(format: "%.0f", (weather?.feelsLike.nigth ?? 99))
        senseLineView.valueLabel.text = "\(senseTemperature)°"
        senseLineView.weatherImg.image = UIImage(named: "termHot")

        windLineView.descriptionLabel.text = "Ветер"
        let windSpeed = NSString(format: "%.0f", (weather?.windSpeed ?? 99))
        windLineView.valueLabel.text = "\(windSpeed)"
        windLineView.weatherImg.image = UIImage(named: "wind")

        ufLineView.descriptionLabel.text = "УФ-излучение"
        let ufIndex = NSString(format: "%.0f", (weather?.uvi ?? 99))
        ufLineView.valueLabel.text = "\(ufIndex)"
        ufLineView.weatherImg.image = UIImage(named: "sun")

        rainFallView.descriptionLabel.text = "Дождь"
        let rainy = NSString(format: "%.0f", ((weather?.pop ?? 99) * 100))
        rainFallView.valueLabel.text = "\(rainy)%"
        rainFallView.weatherImg.image = UIImage(named: "cloudRain")

        cloudyView.descriptionLabel.text = "Облачность"
        cloudyView.valueLabel.text = "\(weather?.clouds ?? 99)%"
        cloudyView.weatherImg.image = UIImage(named: "cloudBlue")
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(21)
            make.left.equalTo(contentView.snp.left).offset(15)
        }

        centerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.centerX.equalTo(contentView.snp.centerX)
        }

        senseLineView.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.bottom).offset(15)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(45)
        }

        windLineView.snp.makeConstraints { make in
            make.top.equalTo(senseLineView.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(45)

        }

        ufLineView.snp.makeConstraints { make in
            make.top.equalTo(windLineView.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(45)

        }

        rainFallView.snp.makeConstraints { make in
            make.top.equalTo(ufLineView.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(45)

        }

        cloudyView.snp.makeConstraints { make in
            make.top.equalTo(rainFallView.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(45)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)

        }
    }
}
