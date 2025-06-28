//
//  ViewController.swift
//  WaerungsRechner
//
//  Created by Alexandre Samson on 25.06.25.
//

import UIKit

// ViewController.swift
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var betragEingabe: UITextField!
    @IBOutlet weak var ergebnisLabel: UILabel!
    @IBOutlet weak var ausgangsWaerungsPicker: UIPickerView!
    @IBOutlet weak var zielWaehrungsPicker: UIPickerView!
    @IBOutlet weak var umrechnenButton: UIButton!
    
    private let viewModel = CurrencyViewModel()
    
    @IBAction func umrechnenGeklickt(_ sender: Any) {
        guard let amountText = betragEingabe.text, let amount = Double(amountText) else {
            ergebnisLabel.text = "Ungültiger Betrag"
            return
        }
        
        viewModel.amount = amount
        viewModel.fromCurrencyIndex = ausgangsWaerungsPicker.selectedRow(inComponent: 0)
        viewModel.toCurrencyIndex = zielWaehrungsPicker.selectedRow(inComponent: 0)
        
        viewModel.convert { [weak self] result in
            self?.ergebnisLabel.text = result
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ausgangsWaerungsPicker.delegate = self
        ausgangsWaerungsPicker.dataSource = self
        zielWaehrungsPicker.delegate = self
        zielWaehrungsPicker.dataSource = self
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.currencies[row]
    }
}
