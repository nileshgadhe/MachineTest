//
//  ListApiResponse.swift
//  MachineTest
//
//  Created by Nilesh Gadhe on 07/04/21.
//  Copyright © 2021 Innofied. All rights reserved.
//

import Foundation

struct ListApiResponse: Decodable {
    
    let page, perPage, total, totalPages: Int?
    let data: [ListApiData]?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }
}

// MARK: - Datum
struct ListApiData: Decodable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
