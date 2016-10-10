//
//  NetworkServiceManager.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 9.10.16.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

//ALAMOFIRE
import Alamofire

public class NetworkServiceManager {
    
    static let sharedInstance = NetworkServiceManager()
    typealias JSONStandard = [String: AnyObject]
    
    func request(url: String) {
        Alamofire.request(url).responseJSON(completionHandler: {
        response in
            self.parseData(JSONData: response.data!)
        })
    }
    
    func parseData(JSONData: Data) {
        do {
            let JSONDataReadable = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as? JSONStandard
            print(JSONDataReadable)
        } catch {
            print(error)
        }
    }

}
