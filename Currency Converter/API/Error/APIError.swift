//
//  APIError.swift
//  Currency Converter
//
//  Created by gigaCheh on 25.01.2024.
//

enum ApiClientError: Error {
    case request
    case network
    case empty
    case service(_ code: Int)
    case deserialize
}
