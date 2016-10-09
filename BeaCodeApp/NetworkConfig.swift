//
//  Constants.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 9.10.16.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

public let SERVER_URL = "www..."

enum ResponseStatusCode {
    case ResponseStatusOk                       //Call Ok
    case ResponseStatusCommunicationError       //Communication with server was unsuccessful
    case ResponseStatusAuthError                //Communication with server was successful, but authentication error received (http 401 or 403)
    case ResponseStatusApplicationError         //Communication with server was successful, but application error received
    case ResponseStatusBusinessError            //Communication with server was successful, but business error received
    case ResponseStatusNoData
}
