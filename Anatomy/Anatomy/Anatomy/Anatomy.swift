//
//  Anatomy.swift
//  Anatomy
//
//  Created by mozhe on 2018/10/29.
//  Copyright © 2018 mozhe. All rights reserved.
//

import Foundation

/// data parser
public struct Anatomy {
    
    // MARK: -- JSON Parser
    
    /// parser JSON to T type Model where T is decodable
    ///
    /// - Parameters:
    ///   - data: JSON data
    ///   - model: T type model is decodable
    /// - Returns: T type model or nil
 public static func parserJSON<T>(with data: Data, to model: T.Type) -> T? where T : Decodable{
        do {
            return try JSONDecoder().decode(model, from: data)
            
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    /// parser bundle JSON file with file's name and extesion type (optional) to T type model
    ///
    /// - Parameters:
    ///   - name: bundle JSON file's name
    ///   - type: T type is decadable
    ///   - model: T type
    /// - Returns: T type model
  public  static func parserLocalJSON<T>(with name: String, type: String?,to model: T.Type) -> T? where T : Decodable {
        
        /* guard let path = Bundle.main.path(forResource: name, ofType: type) else { return  nil}
         guard let data = FileHandle(forReadingAtPath: path)?.availableData else { return nil }
         
         return parserJson(with: data,to: model)
         */
        var newModel: T? = nil
        dataFromLocalResource(with: name, type: type) { (data) in
            guard let data = data else { return }
            newModel = parserJSON(with: data, to: model)
        }
        return newModel
    }
    
    
    /// data from local file
    ///
    /// - Parameters:
    ///   - name: resource's name
    ///   - type: resources file's extension type
    ///   - completion: closer with argument Data?
  public  static func dataFromLocalResource(with name: String, type: String?, completion: @escaping (Data?) -> ()) {
        doInBackgound {
            guard let path = Bundle.main.url(forResource: name, withExtension: type) else {
                doInMain {
                    completion(nil)
                }
                return
            }
            do {
                let data = try FileHandle(forReadingFrom: path).availableData
                doInMain {
                    completion(data)
                }
            }catch {
                doInMain {
                    print(error)
                    completion(nil)
                }
            }
        }
    }
    
    // MARK: -- XML Parser
    /*  platform :ios, '8.0'
     use_frameworks!
     
     pod "SwiftyXMLParser", :git => 'https://github.com/yahoojapan/SwiftyXMLParser.git'
     
     or SWXMLHash
     */
    
}



