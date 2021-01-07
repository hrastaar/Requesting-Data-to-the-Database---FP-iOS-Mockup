//
//  main.swift
//  Requesting Data to the Database - FP iOS Mockup
//
//  Created by Rastaar Haghi on 12/28/20.
//

import Foundation
import Alamofire
import SwiftyJSON

var users = [User]()
print("About to make api call")
let urlString = "https://staging.fightpandemics.work/api/users/"
AF.request(urlString).response { data in
    print(data)
    guard let userData = data.data else { return }
    do {
        let jsonData = JSON(userData).arrayValue
        for element in jsonData {
            let user = try JSONDecoder().decode(User.self, from: element.rawData())
            print(user)
        }
        users = try JSONDecoder().decode([User].self, from: userData)
    } catch {
        print(error.localizedDescription)
    }
    
}
dispatchMain()
