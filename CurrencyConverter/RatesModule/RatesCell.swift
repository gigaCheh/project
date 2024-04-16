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

    }
    
    func update(model: Model) {
        
        
    }
}

private extension RatesCell {
    
    func setupSubviews() {
        
    }
}
