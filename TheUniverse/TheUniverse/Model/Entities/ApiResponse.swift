//
//  Response.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 19/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

struct ApiResponse: Codable {
    let collection: Collection
}

struct Collection: Codable {
    let items: [Items]
}

struct Items: Codable {
    var links: [Links]
}

struct Links: Codable {
    var href: String
}
