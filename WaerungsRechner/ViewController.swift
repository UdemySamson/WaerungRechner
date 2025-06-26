//
//  ViewController.swift
//  WaerungsRechner
//
//  Created by Alexandre Samson on 25.06.25.
//

import UIKit

class ViewController: UIViewController {
    
    private let apiKey = "120a2a22f17ec743ce923b9e"
    
    let waerungen = ["USD", "EUR", "CHF", "GBP", "JPY", "RUB"]
    
    @IBOutlet weak var betragEingabe: UITextField!
    
    @IBOutlet weak var ergebnisLabel: UILabel!
        
    @IBOutlet weak var ausgangsWaerungsPicker: UIPickerView!
    
    @IBOutlet weak var zielWaehrungsPicker: UIPickerView!
        
    @IBOutlet weak var umrechnenButton: UIButton!
    
    @IBAction func umrechnenGeklickt(_ sender: Any) {
        guard let betragIsDouble = Double(betragEingabe.text ?? "") else {
            ergebnisLabel.text = "Ungültiger Betrag"
            return
        }
        
        let ausgangWaehrungIndex = ausgangsWaerungsPicker.selectedRow(inComponent: 0)
        let zielWaehrungIndex = zielWaehrungsPicker.selectedRow(inComponent: 0)
        
        let ausgangsWaehrung = waerungen[ausgangWaehrungIndex]
        let ziehlWaehrung = waerungen[zielWaehrungIndex]
        
        umrechnenWaehrung(betrag: betragIsDouble, von: ausgangsWaehrung, zu: ziehlWaehrung) { result in
            if let result = result {
                self.ergebnisLabel.text = String(format: "%.2f", result ?? 0.0)
            } else {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ausgangsWaerungsPicker.delegate = self
        ausgangsWaerungsPicker.dataSource = self
        
        zielWaehrungsPicker.delegate = self
        zielWaehrungsPicker.dataSource = self
    }
    
    func umrechnenWaehrung(betrag: Double, von: String, zu: String, completion: @escaping (Double?) -> Void) {
        let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(von)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
            
            if let rateResponse = try? JSONDecoder().decode(RateResponse.self, from: data) {
                if let rate = rateResponse.conversion_rates[zu] {
                    let umgerechneteBetrag = betrag * rate
                    DispatchQueue.main.async {
                        completion(umgerechneteBetrag)
                    }
                }
                else {
                    print("Kein wechselkurs für \(von) gefunden.")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }; task.resume()
    }
    
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
    
    enum CodingKeys: String, CodingKey {
        case result
        case documentation
        case terms_of_use = "terms_of_use"
        case time_last_update_unix = "time_last_update_unix"
        case time_last_update_utc = "time_last_update_utc"
        case time_next_update_unix = "time_next_update_unix"
        case time_next_update_utc = "time_next_update_utc"
        case base_code = "base_code"
        case conversion_rates = "conversion"
        
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return waerungen.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return waerungen[row]
    }
}
