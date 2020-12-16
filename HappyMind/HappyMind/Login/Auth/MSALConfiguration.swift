//
//  MSALConfiguration.swift
//  HappyMind
//
//  Created by Carlos Pava on 16/12/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

final class MSALConfiguration {

    static var kClientID: String {
        #if DEBUG
            return "74f02f30-c9e1-4bbe-864f-709c1902b0a6"
        #else
            return "Prod"
        #endif
    }
    
    static var kRedirectUri: String {
        #if DEBUG
            return "msauth.co.edu.sena.HappyMind://auth"
        #else
            return "Prod"
        #endif
    }
    
    static var kAuthority: String {
        #if DEBUG
            return "https://login.microsoftonline.com/cbc2c381-2f2e-4d93-91d1-506c9316ace7"
        #else
            return "Prod"
        #endif
    }
    
    static var kGraphEndpoint: String {
        #if DEBUG
            return "https://graph.microsoft.com/"
        #else
            return "Prod"
        #endif
    }
}
