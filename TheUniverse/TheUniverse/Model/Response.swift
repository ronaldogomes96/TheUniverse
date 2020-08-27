//
//  Response.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 19/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

struct Response: Decodable {
    let collection: Collection
}

struct Collection: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    var links: [Links]
}

struct Links: Decodable {
    var href: String
}
