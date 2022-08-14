//
//  Request.swift
//  TheSports
//
//  Created by Ahmed Yamany on 12/08/2022.
//

import Foundation
import UIKit

class Request{
    var request: CustomNetworkRequests
    var queryItems: [URLQueryItem]!
    
    init(_ request: CustomNetworkRequests, queryItems: [URLQueryItem]! = nil){
        self.request = request
        self.queryItems = queryItems
    }
    
    var url: String {
        return MainNetworkURL + request.endpoint()
    }
  
    var urlComponent: URLComponents{
        var component = URLComponents(string: url)!
        component.queryItems = queryItems
        return component
    }
    
     func featchData<T>() async throws -> T where T: Codable{
       
        let (data, response) = try await URLSession.shared.data(from: urlComponent.url!)

         guard let HttpResponse = response as? HTTPURLResponse, HttpResponse.statusCode == 200 else{
            throw CustomErrors.itemNotFound // if request not complete throw an error
        }
        
         let modelType: T.Type = request.type()

         let decodedData = try JSONDecoder().decode(modelType, from: data)
         
         return decodedData

    }
    
    static func featchImage(from url: URL) async throws -> UIImage{
        let (date, response) = try await URLSession.shared.data(from: url)
        
        guard let HttpResponse = response as? HTTPURLResponse, HttpResponse.statusCode == 200, let image = UIImage(data: date) else{
            throw CustomErrors.ImageDataMissing
        }
        
        return image
    }

}
