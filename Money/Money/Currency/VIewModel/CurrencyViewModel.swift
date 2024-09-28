//
//  CurrencyViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 25.09.2024.
//

import Foundation

protocol CurrencyViewModelProtocol {
    var showError: ((String) -> Void)? { get set }
    var dollarPrice: String { get }
    var euroPrice: String { get }
    
    func loadData()
}

final class CurrencyViewModel: CurrencyViewModelProtocol {
    // MARK: - Properties
    var showError: ((String) -> Void)?
    var dollarPrice: String = ""
    var euroPrice: String = ""
    
    // MARK: - Initialization
    init() {
        loadData()
    }

    // MARK: - Methods
    func loadData() {
        ApiManager.getNews() { [weak self] result in
            self?.handleResult(result)
        }
    }
    
    func handleResult(_ result: Result<CurrencyObject, Error>) {
        switch result {
        case .success(let currency):
            self.convertToLabel(currency)
        case .failure(let error):
            DispatchQueue.main.async {
                self.showError?(error.localizedDescription)
            }
        }
    }

    func convertToLabel(_ currency: CurrencyObject) {
        dollarPrice = String(format: "%.2f", 1 / currency.conversionRates.USD)
        euroPrice = String(format: "%.2f", 1 / currency.conversionRates.EUR)
    }
}

