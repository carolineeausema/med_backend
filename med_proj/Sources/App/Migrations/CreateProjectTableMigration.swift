//
//  
//
//
//  Created by ☮︎ on 3/22/24.
//

import Foundation
import Fluent

struct CreateProjectTableMigration: AsyncMigration {
    
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("Projects")
            .id()
            .field("name", .string, .required)
            .field("start_date", .string, .required)
            .field("end_date", .string, .required)
            .field("budget", .string, .required)
            .field("sponsor", .uuid, .references("Departments", "id"))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("Projects")
            .delete()
    }
    
}
