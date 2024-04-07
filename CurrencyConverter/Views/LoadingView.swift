//
//  LoadingView.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 30.03.2024.
//

import UIKit

final class LoadingView: UIView {
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    // UIActivityIndicator

    func loadView() {
        activityIndicatorView.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    func update(text: String, image: UIImage) {
        
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoadingView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        backgroundColor = .white
    }

    func setupConstraints() {
        
    }
}

