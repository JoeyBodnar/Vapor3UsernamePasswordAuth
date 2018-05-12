import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    let userController = UserController()
    router.get("createUser", use: userController.createUser)
    router.get("loginUser", use: userController.loginUser)

}
