//
//  ErrorView.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 30.03.2024.
//

import UIKit

final class ErrorView: UIView {
    
    private let errorImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Error Occured"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    func update(text: String) {
        errorLabel.text = text
    }
    
    func update(text: String, image: UIImage?) {
        errorImageView.image = image
        errorLabel.text = text
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ErrorView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        backgroundColor = .white
        
        addSubview(errorImageView)
        addSubview(errorLabel)
        addSubview(retryButton)
    }

    func setupConstraints() {
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorImageView.widthAnchor.constraint(equalToConstant: 140.0),
            errorImageView.heightAnchor.constraint(equalToConstant: 140.0),
            errorImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            errorLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 20.0),
        ])
        
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40.0),
        ])
    }
 
}
