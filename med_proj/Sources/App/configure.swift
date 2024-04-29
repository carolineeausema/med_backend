import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.databases.use(.postgres(hostname: "flora.db.elephantsql.com", username: "mzxwccrg", password: "v77-D6ze7U-VGZ_sdARtrabNKcudBvge", database: "mzxwccrg"), as: .psql)
    
    app.migrations.add(CreateDepartmentTableMigration())
    app.migrations.add(CreateEmployeesTableMigration())
    app.migrations.add(CreateProjectTableMigration())

    // register routes
    try routes(app)
}
