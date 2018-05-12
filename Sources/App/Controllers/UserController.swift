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
    // Note: this returns a Future<User>, but in a real world application, which includes
    // the users's hashed password. In a real world application, you should not pass
    // back the user's password to them, even if it is hashed
    func createUser(_ request: Request) throws -> Future<User> {
        return try request.content.decode(User.self).flatMap(to: User.self) { (user) -> Future<User> in
            let passwordHashed = try request.make(BCryptDigest.self).hash(user.password)
            let newUser = User(username: user.username, password: passwordHashed)
            return newUser.save(on: request)
        }
    }
    
    func loginUser(_ request: Request) throws -> Future<User> {
        return try request.content.decode(User.self).flatMap(to: User.self) { user in
            let passwordVerifier = try request.make(BCryptDigest.self)
            return User.authenticate(username: user.username, password: user.password, using: passwordVerifier, on: request).unwrap(or: Abort.init(HTTPResponseStatus.unauthorized))
        }
    }
    
}
