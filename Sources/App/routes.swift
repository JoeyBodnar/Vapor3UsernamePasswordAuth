import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    let userController = UserController()
    router.post("createUser", use: userController.createUser)
    router.post("loginUser", use: userController.loginUser)
    
    let tokenAuthenticationMiddleware = User.tokenAuthMiddleware()
    let authedRoutes = router.grouped(tokenAuthenticationMiddleware)
    authedRoutes.get("this/protected/route") { request -> Future<User.PublicUser> in
        let user = try request.requireAuthenticated(User.self)
        return try user.authTokens.query(on: request).first().map(to: User.PublicUser.self) { userTokenType in
            guard let tokenType = userTokenType?.token else { throw Abort.init(HTTPResponseStatus.notFound) }
            return User.PublicUser(username: user.username, token: tokenType)
        }
    }
}
