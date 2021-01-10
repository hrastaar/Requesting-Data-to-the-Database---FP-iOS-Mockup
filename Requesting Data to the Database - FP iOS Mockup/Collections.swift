//
//  Collections.swift
//  Requesting Data to the Database - FP iOS Mockup
//
//  Created by Rastaar Haghi on 12/28/20.
//

/*
 Created Decodable objects for MongoDB Physical Model found at: https://fightpandemics.github.io/DataModel/#553729a1-8bc8-11ea-8bf8-cf9318f71002
 I had some confusion around the user object type oneOf, and anyOf. For oneOf, physical model
 included either individual account info, or organization account info. Both are classes inherited
 from an AccountChoice type. AnyOf contains either EmailInfo, or PhoneInfo as the class type, both
 inheriting from base class AnyOf.
 */

import Foundation

// 1.1.3.1.1
struct Location: Decodable {
    let address: String?
    let city: String?
    let state: String?
    let country: String?
    let zip: String?
    let coordinates: [Double]?

    enum CodingKeys: String, CodingKey {
        case address
        case city
        case state
        case country
        case zip
        case coordinates
    }
}

// 1.1.3.10.2
struct Author: Decodable {
    let id: String
    let name: String
    let type: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case location
    }
}

// 2.1.2.1.3
struct Comments: Decodable {
    let id: String
    let createdAt: String
    let updatedAt: String
    let author: Author
    let postId: String
    let parentId: String?
    let content: String
    let likes: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt
        case updatedAt
        case author
        case postId
        case parentId
        case content
        case likes
    }
}

// 2.1.2.2.2
struct Feedback: Decodable {
    let id: String
    let createdAt: String
    let updatedAt: String
    let rating: Int
    let ipAddress: String
    let age: Int64?
    let mostValuableFeature: String?
    let whatWouldChange: String?
    let generalFeedback: String?
    let covidImpact: String?
    let userId: String?
    let location: Location?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt
        case updatedAt
        case rating
        case ipAddress
        case age
        case mostValuableFeature
        case whatWouldChange
        case generalFeedback
        case covidImpact
        case userId
        case location
    }
}

// 2.1.2.3.1
struct Posts: Decodable {
    let id: String
    let createdAt: String
    let updatedAt: String
    let expireAt: String?
    let author: Author
    let title: String
    let content: String
    let objective: String
    let visibility: String
    let likes: [String]
    let types: [String]?
    let language: [String]?
    let externalLinks: ExternalLinks

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt
        case updatedAt
        case expireAt
        case author
        case title
        case content
        case objective
        case visibility
        case likes
        case types
        case language
        case externalLinks
    }
}

// 2.1.2.3.3.16
struct ExternalLinks: Decodable {
    let email: String?
    let website: String?
    let playStore: String?
    let appStore: String?

    enum CodingKeys: String, CodingKey {
        case email
        case website
        case playStore
        case appStore
    }
}

// 2.1.2.4.3
struct User: Decodable {
    let id: String
    let createdAt: String
    let updatedAt: String
    let authId: String
    let location: Location?
    let about: String?
    let photo: String?
    let oneOf: AccountChoice? // two subschema's: individual account, organization account
    let anyOf: AnyOf?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt
        case updatedAt
        case authId
        case location
        case about
        case photo
        case oneOf
        case anyOf
    }
}

// 2.1.2.4.3.13.2
struct IndividualNeeds: Decodable {
    let medicalHelp: Bool
    let otherHelp: Bool

    enum CodingKeys: String, CodingKey {
        case medicalHelp
        case otherHelp
    }
}

// 2.1.2.4.3.16.2
struct UserObjectives: Decodable {
    let donate: Bool
    let shareInformation: Bool
    let volunteer: Bool

    enum CodingKeys: String, CodingKey {
        case donate
        case shareInformation
        case volunteer
    }
}

// 2.1.2.4.3.20.2
struct IndividualAccountURLs: Decodable {
    let facebook: String?
    let linkedin: String?
    let twitter: String?
    let github: String?
    let website: String?

    enum CodingKeys: String, CodingKey {
        case facebook
        case linkedin
        case twitter
        case github
        case website
    }
}

// 2.1.2.4.3.26.2
struct OrganizationObjectives: Decodable {
    let type: String
    let industry: String
    let ownerId: String
    let name: String
    let needs: OrganizationNeeds
    let global: Bool?
    let urls: IndividualAccountURLs
    let language: String?

    enum CodingKeys: String, CodingKey {
        case type
        case industry
        case ownerId
        case name
        case needs
        case global
        case urls
        case language
    }
}

// 2.1.2.4.3.31.2
struct OrganizationNeeds: Decodable {
    let volunteers: Bool
    let donations: Bool
    let staff: Bool
    let other: Bool

    enum CodingKeys: String, CodingKey {
        case volunteers
        case donations
        case staff
        case other
    }
}

// 2.1.2.4.3.37.2
struct OrganizationURLs: Decodable {
    let linkedin: String?
    let twitter: String?
    let website: String?
    let playstore: String?
    let appstore: String?

    enum CodingKeys: String, CodingKey {
        case linkedin
        case twitter
        case website
        case playstore
        case appstore
    }
}

struct Hide: Decodable {
    let address: Bool

    enum CodingKeys: String, CodingKey {
        case address
    }
}

class AccountChoice: Decodable {
    let type: String

    enum CodingKeys: String, CodingKey {
        case type
    }
}

// 2.1.2.4.3.8.3
class IndividualAccountChoice: AccountChoice {
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? nil
        needs = try container.decode(IndividualNeeds.self, forKey: .needs)
        objectives = try container.decodeIfPresent(UserObjectives.self, forKey: .objectives) ?? nil
        urls = try container.decodeIfPresent(IndividualAccountURLs.self, forKey: .urls) ?? nil
        try super.init(from: decoder)
    }

    let firstName: String
    let lastName: String?
    let needs: IndividualNeeds
    let objectives: UserObjectives?
    let urls: IndividualAccountURLs?

    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case needs
        case objectives
        case urls
    }
}

// 2.1.2.4.3.26.2
class OrganizationChoice: AccountChoice {
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        industry = try container.decode(String.self, forKey: .industry)
        ownerId = try container.decode(String.self, forKey: .ownerId)
        name = try container.decode(String.self, forKey: .name)
        needs = try container.decode(OrganizationNeeds.self, forKey: .needs)
        global = try container.decodeIfPresent(Bool.self, forKey: .global)
        urls = try container.decodeIfPresent(OrganizationURLs.self, forKey: .urls) ?? nil
        language = try container.decodeIfPresent(String.self, forKey: .language) ?? nil
        try super.init(from: decoder)
    }

    let industry: String
    let ownerId: String
    let name: String
    let needs: OrganizationNeeds
    let global: Bool?
    let urls: OrganizationURLs?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case type
        case industry
        case ownerId
        case name
        case needs
        case global
        case urls
        case language
    }
}

class AnyOf: Decodable {
    // subclass used for either emailInfo or PhoneInfo
}

// 2.1.2.4.3.45.2
class EmailInfo: AnyOf {
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        email = try container.decode(String.self, forKey: .email)
        try super.init(from: decoder)
    }

    let email: String

    enum CodingKeys: String, CodingKey {
        case email
    }
}

// 2.1.2.4.3.47.2
class PhoneInfo: AnyOf {
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        phone = try container.decode(String.self, forKey: .phone)
        try super.init(from: decoder)
    }

    let phone: String

    enum CodingKeys: String, CodingKey {
        case phone
    }
}
