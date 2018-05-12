//
//  UserController.swift
//  App
//
//  Created by Stephen Bodnar on 5/12/18.
//

import Foundation
import Vapor
import Authentication

final class UserController {
    func createUser(_ request: Request) throws -> Future<User> {
        return try request.content.decode(User.self).flatMap(to: User.self) { (user) -> Future<User> in
            let passwordHashed = try request.make(BCryptDigest.self).hash(user.password)
            let newUser = User(username: user.username, password: passwordHashed)
            return newUser.save(on: request)
        }
    }
    
    func loginUser(_ request: Request) throws -> Future<User> {
        // Add login implementation here
    }
    
}
