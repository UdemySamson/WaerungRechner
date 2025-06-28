//
//  CurrencyViewModel.swift
//  WaerungsRechner
//
//  Created by Alexandre Samson on 28.06.25.
//

import Foundation

import Foundation

class CurrencyViewModel {
    let currencies = ["USD","AED","AFN","ALL","AMD","ANG","AOA","ARS","AUD","AWG","AZN","BAM",
                      "BBD","BDT","BGN","BHD","BIF","BMD","BND","BOB","BRL","BSD","BTN","BWP",
                      "BYN","BZD","CAD","CDF","CHF","CLP","CNY","COP","CRC","CUP","CVE","CZK",
                      "DJF","DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","FKP","FOK","GBP",
                      "GEL","GGP","GHS","GIP","GMD","GNF","GTQ","GYD","HKD","HNL","HRK","HTG",
                      "HUF","IDR","ILS","IMP","INR","IQD","IRR","ISK","JEP","JMD","JOD","JPY",
                      "KES","KGS","KHR","KID","KMF","KRW","KWD","KYD","KZT","LAK","LBP","LKR",
                      "LRD","LSL","LYD","MAD","MDL","MGA","MKD","MMK","MNT","MOP","MRU","MUR",
                      "MVR","MWK","MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD","OMR",
                      "PAB","PEN","PGK","PHP","PKR","PLN","PYG","QAR","RON","RSD","RUB","RWF",
                      "SAR","SBD","SCR","SDG","SEK","SGD","SHP","SLE","SOS","SRD","SSP","STN",
                      "SYP","SZL","THB","TJS","TMT","TND","TOP","TRY","TTD","TVD","TWD","TZS",
                      "UAH","UGX","UYU","UZS","VES","VND","VUV","WST","XAF","XCD","XDR","XOF",
                      "XPF","YER","ZAR","ZMW","ZWL"]
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
