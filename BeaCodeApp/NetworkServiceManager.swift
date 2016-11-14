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
    func makeRequest(serviceCall: ServiceCall, completition: @escaping (_ result: Bool) -> Void)
}

public class NetworkServiceManager: NetworkServiceManagerProtocol {
    
    static let sharedInstance = NetworkServiceManager()
    var header = ["Accept": "application/json"]
    
    func makeRequest(serviceCall: ServiceCall, completition: @escaping (_ result: Bool) -> Void) {

        let requestUrl = SERVER_URL + serviceCall.requestUrl

        Alamofire.request(requestUrl,
                          method: serviceCall.requestMethod,
                          parameters: serviceCall.requestParams,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON { response in

                            switch response.response!.statusCode {
                                case 200:
                                    print(response.result.debugDescription)
                                    completition(true)
                                case 400:
                                    completition(false)
                                case 401:
                                    completition(false)
                                case 404:
                                    completition(false)
                                case 500:
                                    completition(false)
                                default: break
                            }
        }
    }

}
