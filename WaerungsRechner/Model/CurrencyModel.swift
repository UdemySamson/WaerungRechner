//
//  CurrencyModel.swift
//  WaerungsRechner
//
//  Created by Alexandre Samson on 28.06.25.
//

import Foundation

struct RateResponse: Decodable {
    let result: String
    let documentation: String
    let terms_of_use: String
    let time_last_update_unix: Int
    let time_last_update_utc: String
    let time_next_update_unix: Int
    let time_next_update_utc: String
    let base_code: String
    let conversion_rates: [String: Double]
}

class CurrencyService {
    private let apiKey = "120a2a22f17ec743ce923b9e"
    
    func convertCurrency(amount: Double, from: String, to: String, completion: @escaping (Double?) -> Void) {
        let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(from)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Fehler: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Keine Daten zurückgegeben.")
                completion(nil)
                return
            }
            
            do {
                let rateResponse = try JSONDecoder().decode(RateResponse.self, from: data)
                if let rate = rateResponse.conversion_rates[to] {
                    let convertedAmount = amount * rate
                    DispatchQueue.main.async {
                        completion(convertedAmount)
                    }
                } else {
                    print("Kein Wechselkurs für \(from) gefunden.")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                print("JSON Decoding Fehler: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
