//
//  ConnectionManager.swift
//  prueba_vector_dani
//
//  Created by Daniel Morato on 05/10/2018.
//  Copyright © 2018 dani. All rights reserved.
//

import Foundation
import Alamofire

class ConnectionManager {
    var delegate: GetRandomUserProtocol?
    var endpointUsers: String = "https://randomuser.me/api/?" +
        "results=20&gender=female&inc=name,email,cell,picture"

    func getRandomUser() {
        Alamofire.request(endpointUsers, method: .get, parameters: nil,
            encoding: JSONEncoding.default, headers: nil).responseString
        {
            [weak self] response in
            if response.result.isSuccess, let user = try?
                JSONDecoder().decode(Users.self, from: response.data!) {
                self!.delegate!.OnGetUserData(users: user)
            }
        }
    }
}

protocol GetRandomUserProtocol {
    func OnGetUserData(users: Users)
}
