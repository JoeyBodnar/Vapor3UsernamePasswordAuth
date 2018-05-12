import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentPostgreSQLProvider())
    try services.register(AuthenticationProvider())
    
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    let psqlConfig = PostgreSQLDatabaseConfig(hostname: "localhost", port: 5432, username: "anapaix", database: "usernamepasswordauth", password: nil)
    let database = PostgreSQLDatabase(config: psqlConfig)
    var dbConfig = DatabasesConfig()
    dbConfig.add(database: database, as: .psql)
    services.register(dbConfig)
    
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql)
    services.register(migrations)

}
