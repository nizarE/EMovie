//
//  Programme.swift
//  EMovie
//
//  Created by Nizar Elhraiech on 15/1/2022.
//

import Foundation

struct User : Decodable {
    let email : String?
    let username : String?
    let token : String?

    init(from decoder : Decoder ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        email = try? container.decode(String.self, forKey: .email)
        username = try? container.decode(String.self, forKey: .username)
        token = try? container.decode(String.self, forKey: .token)
    }
    
    
}
