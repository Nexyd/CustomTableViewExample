//
//  User.swift
//  prueba_vector_dani
//
//  Created by Daniel Morato on 05/10/2018.
//  Copyright © 2018 dani. All rights reserved.
//

import Foundation

class User: Codable {
    var name: Username?
    var email: String?
    var cell: String?
    var picture: ImageURL?
}

class Users: Codable {
    var results: [User]
}
