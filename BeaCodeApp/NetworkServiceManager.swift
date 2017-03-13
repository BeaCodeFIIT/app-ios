//
//  NetworkServiceManager.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 9.10.16.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

//ALAMOFIRE
import Alamofire
import SwiftyJSON

public class NetworkServiceManager {
    
    static let sharedInstance = NetworkServiceManager()
    var header = ["Accept": "application/json",
                  "deviceId": "15251512"
                  ]
    
    func makeRequest(serviceCall: ServiceCall, completition: @escaping (_ result: JSON?) -> Void) {

        let requestUrl = SERVER_URL + serviceCall.requestUrl

        Alamofire.request(requestUrl,
                          method: serviceCall.requestMethod,
                          parameters: serviceCall.requestParams,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON { response in

                            switch response.response!.statusCode {
                                case 200:
                                    print(response.result.debugDescription)
                                    completition(JSON(data: response.data!))
                                case 400:
                                    completition(nil)
                                case 401:
                                    completition(nil)
                                case 404:
                                    completition(nil)
                                case 500:
                                    completition(nil)
                                default: break
                            }
        }
    }

}
