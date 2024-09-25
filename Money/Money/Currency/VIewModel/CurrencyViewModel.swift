//
//  CurrencyViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 25.09.2024.
//

import Foundation

protocol CurrencyViewModelProtocol {
    func loadData()
    var showError: ((String) -> Void)? { get set }
    var dollarPrice: String { get }
    var euroPrice: String { get }
}

final class CurrencyViewModel: CurrencyViewModelProtocol {
    var showError: ((String) -> Void)?
    var dollarPrice: String = ""
    var euroPrice: String = ""
    
    init() {
        loadData()
    }
    
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
        dollarPrice = currency.USDRUB
        euroPrice = currency.EURRUB
        }
    }

