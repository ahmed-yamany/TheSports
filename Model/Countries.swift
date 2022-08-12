//
//  Countries.swift
//  TheSports
//
//  Created by Ahmed Yamany on 12/08/2022.
//

import Foundation

struct Countries: Codable{
    var countries: [Country]
    
}

struct Country: Codable{
    var name: String
    
    enum CodingKeys: String, CodingKey{
        case name = "name_en"
    }
    
}

