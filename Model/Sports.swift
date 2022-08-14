//
//  Sports.swift
//  TheSports
//
//  Created by Ahmed Yamany on 12/08/2022.
//

import Foundation
import UIKit

struct Sports: Codable{
    var sports: [Sport]

}



struct Sport: Codable{
    var id: String
    var name: String
    var formate: String
    var banner: URL!
    var icon: URL!
    var description: String
        
    var bannerImage: UIImage!
    var iconImage: UIImage!
    
    enum CodingKeys: String, CodingKey{
        case id = "idSport"
        case name = "strSport"
        case formate = "strFormat"
        case banner = "strSportThumb"
        case icon = "strSportIconGreen"
        case description = "strSportDescription"
        
        
        
    }

}
