//
//  dateTableViewCell.swift
//  WeatherApp
//
//  Created by admin on 15.04.2022.
//

import UIKit

protocol DTVSDelegate: AnyObject {
    func reloadDataInTableView()
}

final class DateTableViewCell: UITableViewCell {

    private weak var delegate: DTVSDelegate?

    private var weather: WeatherModelDaily?

    private let dateCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let dateCollectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: flowLayout)
        dateCollectionView.showsVerticalScrollIndicator = false
        dateCollectionView.showsHorizontalScrollIndicator = false

        return dateCollectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        dateCollectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "DateCollectionViewCell")
        contentView.addSubview(dateCollectionView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setWeather(_ weather: WeatherModelDaily) {
        self.weather = weather
    }

    func changeSelectedCollectionViewCell(to index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        dateCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }

    func setTableViewCell(delegate: DTVSDelegate) {
        self.delegate = delegate
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    private func setupConstraints() {
        dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

extension DateTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 // погода на 7 дней
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as? DateCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setCollectionViewCell(delegate: self.delegate as? DCVCDelegate)
        cell.changeIndexTo(indexPath.row)
        if let weather = weather {
            cell.setWeather(weather)
        }
        return cell
    }
}

extension DateTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 36)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.reloadDataInTableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 6, bottom: 28, right: 6)
    }

}

extension DateTableViewCell: UICollectionViewDelegate {

}
