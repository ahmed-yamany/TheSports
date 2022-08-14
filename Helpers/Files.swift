//
//  Files.swift
//  TheSports
//
//  Created by Ahmed Yamany on 14/08/2022.
//

import Foundation

struct Files{
    var request: CustomNetworkRequests  // current request type
    var archiveURL: URL // file path to save to
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    init(request: CustomNetworkRequests){
        self.request = request
        self.archiveURL = Files.documentsDirectory.appendingPathComponent(request.filePath()).appendingPathExtension("plist")
    }
    // load data from file
    func loadModels<T>() -> T? where T: Codable {
        guard let codedData = try? Data(contentsOf: archiveURL) else
          {return nil}
        
       let propertyListDecoder = PropertyListDecoder()
        
        let modelType: T.Type = request.filesDataTypes()
        let decodedData =  try? propertyListDecoder.decode(modelType, from: codedData)
        
        return decodedData
   }
    
    //save data to file
    func saveToFiles<T>(_ type: T) where T: Codable{
       let propertyListEncoder = PropertyListEncoder()
       let codedToDos = try? propertyListEncoder.encode(type)
       try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
   }

        
}
