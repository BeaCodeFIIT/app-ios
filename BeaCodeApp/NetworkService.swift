//
//  NetworkService.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 9.10.16.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

public enum ServiceMethod {
    case GET
    case POST
    case PUT
    case DELETE
}

public struct NetworkService {

    public let serviceUrl: String
    public let serviceMethod: ServiceMethod
    public let serviceData: Dictionary<String, String>

}
