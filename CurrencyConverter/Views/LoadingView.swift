//
//  LoadingView.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 30.03.2024.
//

import UIKit

final class LoadingView: UIView {
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init() {
        super.init(frame: .zero)
        commonInit()
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
        addSubview(activityIndicatorView)
    }

    func setupConstraints() {
        // TODO: activityIndicatorView - 40x40 + по центру
        
        activityIndicatorView.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicatorView.startAnimating()
    }
}

