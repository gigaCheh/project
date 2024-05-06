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
        let curImage: UIImage?
        let rate: String  // "42.492057"
        let rateDescription: String // "1 GBP = 11.766905 SEK"
    }
    
    private let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "GBP"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let currencyDescLabel: UILabel = {
        let label = UILabel()
        label.text = "Pound sterling"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .gray
        return label
    }()
    
    private var currencyImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var currencyRate: UILabel = {
        let label = UILabel()
        label.text = "42.492057"
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private var currencyRateDesc: UILabel = {
        let label = UILabel()
        label.text = "1 GBP = 11.766905 SEK"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private let topLineStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private let lowerLineStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        setupSubviews()
        setupConstraint()
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
        contentView.addSubview(topLineStack)
        contentView.addSubview(lowerLineStack)
        
        
        topLineStack.addArrangedSubview(currencyNameLabel)
        topLineStack.addArrangedSubview(currencyRate)
        topLineStack.backgroundColor = .random()
        
        lowerLineStack.addArrangedSubview(currencyDescLabel)
        lowerLineStack.addArrangedSubview(currencyRateDesc)
        lowerLineStack.backgroundColor = .random()
    }
    
    func setupConstraint() {
        currencyImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            currencyImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currencyImage.widthAnchor.constraint(equalToConstant: 28),
            currencyImage.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        topLineStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLineStack.leadingAnchor.constraint(equalTo: currencyImage.trailingAnchor, constant: 10),
            topLineStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topLineStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2)
        ])
        
        lowerLineStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lowerLineStack.leadingAnchor.constraint(equalTo: currencyImage.trailingAnchor, constant: 10),
            lowerLineStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lowerLineStack.topAnchor.constraint(equalTo: topLineStack.topAnchor, constant: 18)
        ])
    }
}
