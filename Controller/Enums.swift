//
//  Enums.swift
//  TheSports
//
//  Created by Ahmed Yamany on 12/08/2022.
//

import Foundation

enum CustomErrors: Error, LocalizedError{
    case itemNotFound, ImageDataMissing
}

enum CustomNetworkRequests: Any{
    
    case sports
    case countries
    case leagues
    
    // returns the endpoint of current network request
    func endpoint() -> String{
        
        switch self {
        case .sports:
            return "all_sports.php"
        case .countries:
            return "all_countries.php"
        case .leagues:
            return "search_all_leagues.php"
        }
    }
    
    
    // returns a custom Swift type that conforms Codable protocol
    func type<T>() -> T.Type where T: Codable{
        switch self {
        case .sports:
            return Sports.self as! T.Type
        case .countries:
            return Countries.self as! T.Type
        case .leagues:
            return Leagues.self as! T.Type
        }
    }
    
    
    
    
    

}
