//
//  ServiceCall.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 14.11.16.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Alamofire

public struct ServiceCall {

    public var requestMethod: HTTPMethod!
    public var requestParams: [String : Any]?
    public var requestUrl: String!

}
