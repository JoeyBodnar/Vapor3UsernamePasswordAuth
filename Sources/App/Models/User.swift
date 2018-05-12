//
//  User.swift
//  App
//
//  Created by Stephen Bodnar on 5/12/18.
//

import Foundation
import Vapor
import FluentPostgreSQL
import Authentication
extension User: PasswordAuthenticatable {
    static var usernameKey: WritableKeyPath<User, String> { return \User.username }
    static var passwordKey: WritableKeyPath<User, String> { return \User.password }
}

final class User: PostgreSQLModel {
    var id: Int?
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension User: Migration { }
extension User: Content { }
extension User: Parameter { }
