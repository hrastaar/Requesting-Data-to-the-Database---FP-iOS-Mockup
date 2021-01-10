//
//  main.swift
//  Requesting Data to the Database - FP iOS Mockup
//
//  Created by Rastaar Haghi on 12/28/20.
//

import Alamofire
import Foundation
import SwiftyJSON

var users = [User]()

func getUsers() {
    print("About to make api call")
    let urlString = "https://staging.fightpandemics.work/api/users/"
    AF.request(urlString)
        .validate(statusCode: 200 ..< 300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                //print(JSON(response.data))
                print("successfully fetched user data")
                guard let userData = response.data else { return }
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
            case .failure:
                print("Encountered error from alamo fire request for user data")
            } /// End Switch Statement
        }
}

func getUserByID(id: String) { /// id: 5ff791646486b1130074e2c3
    print("About to make api call")
    let urlString = "https://staging.fightpandemics.work/api/users/\(id)"
    AF.request(urlString)
        .validate(statusCode: 200 ..< 300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                print(JSON(response.data))
                print("successfully fetched user data")
                guard let userData = response.data else { return }
                do {
                    let user = try JSONDecoder().decode(User.self, from: userData)
                    print(user)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure:
                print("Encountered error from alamo fire request for user data")
            } /// End Switch Statement
        }
}
//getUsers()
getUserByID(id: "5ff791646486b1130074e2c3")
dispatchMain()
