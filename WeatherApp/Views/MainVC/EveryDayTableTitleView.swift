//
//  EveryDayTableTitleView.swift
//  WeatherApp
//
//  Created by admin on 29.03.2022.
//

import UIKit

class EveryDayTableTitleView: UIView {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Ежедневный прогноз"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.textColor = .black
        return titleLabel
    }()

    private let howMuchDaysButton: UIButton = {
       let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        let attrString = NSMutableAttributedString(string: "7 дней", attributes: attributes)
        button.setAttributedTitle(attrString, for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [titleLabel, howMuchDaysButton].forEach { item in
            self.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        howMuchDaysButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    func setButtonTarget(_ target: Any?, action: Selector) {
        howMuchDaysButton.addTarget(target, action: action, for: .touchUpInside)
    }

}
