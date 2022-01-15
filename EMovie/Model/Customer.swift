//
//  Customer.swift
//  EMovie
//
//  Created by Nizar Elhraiech on 15/1/2022.
//

import Foundation

struct Customer : Decodable {
    let id : Int?
    let name : String?
    let logo : String?
    
    init(from decoder : Decoder ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        logo = try? container.decode(String.self, forKey: .logo)
    }
    
    
}
