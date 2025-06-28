//
//  CurrencyViewModel.swift
//  WaerungsRechner
//
//  Created by Alexandre Samson on 28.06.25.
//

import Foundation

import Foundation

class CurrencyViewModel {
    let currencies = ["USD", "EUR", "CHF", "GBP", "JPY", "RUB"]
    private let currencyService = CurrencyService()
    
    var amount: Double = 0.0
    var fromCurrencyIndex: Int = 0
    var toCurrencyIndex: Int = 0
    
    func convert(completion: @escaping (String?) -> Void) {
        guard amount > 0 else {
            completion("Ungültiger Betrag")
            return
        }
        
        let fromCurrency = currencies[fromCurrencyIndex]
        let toCurrency = currencies[toCurrencyIndex]
        
        currencyService.convertCurrency(amount: amount, from: fromCurrency, to: toCurrency) { result in
            if let result = result {
                completion(String(format: "%.2f", result))
            } else {
                completion("Umrechnung fehlgeschlagen")
            }
        }
    }
}
