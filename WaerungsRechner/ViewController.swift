//
//  ViewController.swift
//  WaerungsRechner
//
//  Created by Alexandre Samson on 25.06.25.
//

import UIKit

class ViewController: UIViewController {
    
    let waerungen = ["USD", "EUR", "CHF", "GBP", "JPY", "RUB"]
    
    @IBOutlet weak var betragEingabe: UITextField!
    
    @IBOutlet weak var ergebnisLabel: UILabel!
        
    @IBOutlet weak var ausgangsWaerungsPicker: UIPickerView!
    
    @IBOutlet weak var zielWaehrungsPicker: UIPickerView!
        
    @IBOutlet weak var umrechnenButton: UIButton!
    
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
        return waerungen.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return waerungen[row]
    }
}
