//
//  User Structs.swift
//  Requesting Data to the Database - FP iOS Mockup
//
//  Created by Rastaar Haghi on 12/28/20.
//

import Foundation

struct User: Decodable {
    let id: String
    let hide: Hide
    let needs: Needs
    let objectives: Objectives
    let type: String
    let firstName: String
    let lastName: String
    let photo: String
    let location: Location?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case hide
        case needs
        case objectives
        case type
        case firstName
        case lastName
        case photo
        case location
    }
}

struct Hide: Decodable {
    let address: Bool
    enum CodingKeys: String, CodingKey {
        case address
    }
}

struct Needs: Decodable {
    let medicalHelp: Bool
    let otherHelp: Bool
    enum CodingKeys: String, CodingKey {
        case medicalHelp
        case otherHelp
    }
}

struct Objectives: Decodable {
    let donate: Bool
    let shareInformation: Bool
    let volunteer: Bool
    enum CodingKeys: String, CodingKey {
        case donate
        case shareInformation
        case volunteer
    }
}

struct Location: Decodable {
    let address: String
    let city: String
    let state: String
    let country: String
    enum CodingKeys: String, CodingKey {
        case address
        case city
        case state
        case country
    }
}
