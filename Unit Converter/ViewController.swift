//
//  ViewController.swift
//  Unit Converter
//
//  Created by Maggie on 2019-01-21.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperaturePicker: UIPickerView!
    @IBOutlet var temperatureRange: TemperatureRange!
    @IBOutlet weak var temperatureSegmented: UISegmentedControl!
    
    let unitConverter = UnitConverter()
    let userDefaultsLastRowKey = "defaultPickerRow"
    let userDefaultsLastSegment = "defaultSegmentIndex"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTemperatureSegmented()
        temperatureSegmented.selectedSegmentIndex = initialSegmentIndex()
        
        //        temperaturePicker.dataSource = self
        temperaturePicker.delegate = self
        temperaturePicker.selectRow(initialPickerView(), inComponent: 0, animated: true)
        
        pickerView(temperaturePicker, didSelectRow: initialPickerView(), inComponent: 0)
    }
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        switch temperatureSegmented.selectedSegmentIndex {
            case 0:
                temperaturePicker.reloadAllComponents()
                pickerView(temperaturePicker, didSelectRow: initialPickerView(), inComponent: 0)
                saveIndex(index: 0)
            case 1:
                temperaturePicker.reloadAllComponents()
                pickerView(temperaturePicker, didSelectRow: initialPickerView(), inComponent: 0)
                saveIndex(index: 1)
            default:
                break
        }
    }
    
    func styleTemperatureSegmented() {
        temperatureSegmented.tintColor = UIColor.orange
        temperatureSegmented.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
    }
    
    func initialPickerView() -> Int {
        if let savedRow = UserDefaults.standard.object(forKey: userDefaultsLastRowKey) as? Int {
            return savedRow
        }
        return temperaturePicker.numberOfRows(inComponent: 0) / 2
    }
    
    func saveSelectedRow(row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: userDefaultsLastRowKey)
        defaults.synchronize()
    }
    
    func initialSegmentIndex() -> Int {
        if let index = UserDefaults.standard.object(forKey: userDefaultsLastSegment) as? Int {
            return index
        }
        return 0
    }
    
    func saveIndex(index: Int) {
        let defaults = UserDefaults.standard
        defaults.set(index, forKey: userDefaultsLastSegment)
        defaults.synchronize()
    }
    
    func displayConvertedTemperatureForRow(row: Int) {
        if temperatureSegmented.selectedSegmentIndex == 0 {
            let degree = unitConverter.degreeC(degreeF: temperatureRange.values[row])
            temperatureLabel.text = "\(degree)°C"
        } else if temperatureSegmented.selectedSegmentIndex == 1 {
            let degree = unitConverter.degreeF(degreeC: temperatureRange.values[row])
            temperatureLabel.text = "\(degree)°F"
        }
    }
}

// 2 ways to extend a default class or object: 1 is to create a subclass and 2 is extend the class
extension ViewController: UIPickerViewDelegate {
    
    // Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if temperatureSegmented.selectedSegmentIndex == 0 {
            return "\(temperatureRange.values[row])°F"
        } else {
            return "\(temperatureRange.values[row])°C"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        displayConvertedTemperatureForRow(row: row)
        saveSelectedRow(row: row)
    }
}

