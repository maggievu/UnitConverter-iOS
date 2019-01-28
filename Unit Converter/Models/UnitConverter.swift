//
//  UnitConverter.swift
//  Unit Converter
//
//  Created by Maggie on 2019-01-21.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import Foundation

class UnitConverter {
    func degreeF(degreeC: Int) -> Int {
        return (Int(Float(degreeC) * 1.8 + 32.0))
    }
    
    func degreeC(degreeF: Int) -> Int {
        return (Int((Float(degreeF) - 32) / 1.8))
    }
}
