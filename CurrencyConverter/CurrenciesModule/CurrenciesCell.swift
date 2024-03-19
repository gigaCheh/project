//
//  CurrenciesCell.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 19.03.2024.
//

import Foundation
import UIKit

final class CurrenciesCell: UITableViewCell {
    static let id = "CurrenciesCellId"
    
    struct Model {
        let text: String
        let isSelected: Bool
    }
    
    private let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        //
        return label
    }()
    
    func update(model: Model) {
        currencyNameLabel.text = model.text
        accessoryType = model.isSelected ? .checkmark : .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
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
        currencyNameLabel.text = nil
    }
}

private extension CurrenciesCell {
    func setupSubviews() {
        contentView.addSubview(currencyNameLabel)
        
        currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            currencyNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            currencyNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
