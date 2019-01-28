//
//  TemperatureRange.swift
//  Unit Converter
//
//  Created by Maggie on 2019-01-21.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit
import Foundation

class TemperatureRange: NSObject, UIPickerViewDataSource {
    
    let values = (-100...100).map { $0 }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
}
