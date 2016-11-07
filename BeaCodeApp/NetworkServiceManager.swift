//
//  NetworkServiceManager.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 9.10.16.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

//ALAMOFIRE
import Alamofire

protocol NetworkServiceManagerProtocol {
    func makeRequest(method: HTTPMethod, url: String, parameteres: Any?)
}

public class NetworkServiceManager: NetworkServiceManagerProtocol {
    
    static let sharedInstance = NetworkServiceManager()
    var header = ["Content-type": "application/json"]
    
    func makeRequest(method: HTTPMethod, url: String, parameteres: Any?) {
        Alamofire.request(url, method: method, parameters: parameteres, encoding: .JSON, headers: header).responseJSON { result in
            
        }
    }

}
