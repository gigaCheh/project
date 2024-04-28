//
//  RatesCell.swift
//  CurrencyConverter
//
//  Created by gigaCheh on 06.04.2024.
//

import Foundation
import UIKit

final class RatesCell: UITableViewCell {
    static let id = "RatesCellId"
    
    struct Model {
        let curName: String  // "GBP"
        let curDesc: String  // "Pound sterling"
        let curImage: UIImage
        let rate: String  // "42.492057"
        let rateDescription: String // "1 GBP = 11.766905 SEK"
    }
    
    private let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "GBP"
        label.textColor = .black
        return label
    }()
    
    private let currencyDescLabel: UILabel = {
        let label = UILabel()
        label.text = "Pound sterling"
        //label.numberOfLines = 0
        //label.setContentCompressionResistancePriority(.required, for: .horizontal)
        //label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    private var currencyImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        return image
    }()
    
    private var currencyRate: UILabel = {
        let label = UILabel()
        label.text = "42.492057"
        label.textColor = .black
        return label
    }()
    
    private var currencyRateDesc: UILabel = {
        let label = UILabel()
        label.text = "1 GBP = 11.766905 SEK"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackViewForName = UIStackView(arrangedSubviews: [currencyNameLabel, currencyRate])
        stackViewForName.distribution = .equalSpacing
        stackViewForName.axis = .horizontal
        stackViewForName.spacing = 8

        
        
        
        let stackViewForDescription = UIStackView(arrangedSubviews: [currencyDescLabel, currencyRateDesc])
        stackViewForDescription.distribution = .equalSpacing
        stackViewForDescription.axis = .horizontal
        stackViewForDescription.spacing = 8

        
        contentView.backgroundColor = .white
        
        addSubview(stackViewForName)
        addSubview(stackViewForDescription)

        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
    func update(model: Model) {
        currencyNameLabel.text = model.curName
        currencyDescLabel.text = model.curDesc
        currencyImage.image = model.curImage
        currencyRate.text = model.rate
        currencyRateDesc.text = model.rateDescription
        
    }
}

private extension RatesCell {
    
    func setupSubviews() {
        contentView.addSubview(currencyImage)
        contentView.addSubview(currencyNameLabel)
        contentView.addSubview(currencyDescLabel)
        contentView.addSubview(currencyRate)
        contentView.addSubview(currencyRateDesc)
        
        currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyDescLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyRate.translatesAutoresizingMaskIntoConstraints = false
        currencyRateDesc.translatesAutoresizingMaskIntoConstraints = false
        currencyImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyNameLabel.trailingAnchor.constraint(equalTo: currencyImage.trailingAnchor, constant: 40),
            currencyNameLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor)
            //currencyNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
            //currencyNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20)
            ])
        
        NSLayoutConstraint.activate([
            currencyDescLabel.trailingAnchor.constraint(equalTo: currencyImage.trailingAnchor, constant: 55),
            currencyDescLabel.leadingAnchor.constraint(equalTo: currencyImage.trailingAnchor, constant: 6),
            currencyDescLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            currencyDescLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            currencyDescLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            currencyRate.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            currencyRate.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            currencyRateDesc.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            currencyRateDesc.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            currencyRateDesc.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            currencyDescLabel.widthAnchor.constraint(equalToConstant: 0)
        ])
        NSLayoutConstraint.activate([
            currencyImage.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            currencyImage.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            currencyImage.widthAnchor.constraint(equalToConstant: 40),
            currencyImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
    }
}
