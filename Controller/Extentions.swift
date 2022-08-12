//
//  Extentions.swift
//  TheSports
//
//  Created by Ahmed Yamany on 12/08/2022.
//

import Foundation

extension Dictionary{
    func ConverToQueryItems() -> [URLQueryItem]{
        
    return self.map{
            URLQueryItem(name: ($0.key as! String), value: ($0.value as! String))
        }
        
    }
}
