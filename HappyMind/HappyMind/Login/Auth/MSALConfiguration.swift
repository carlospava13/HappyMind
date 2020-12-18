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
        return "ed9d844d-39aa-47a1-a904-132a948fee77"
    }

    static var kRedirectUri: String {
        return "msauth.co.edu.sena.happymind://auth"
    }

    static var kAuthority: String {
        return "https://login.microsoftonline.com/cbc2c381-2f2e-4d93-91d1-506c9316ace7"
    }

    static var kGraphEndpoint: String {
        return "https://graph.microsoft.com/"
    }
}
