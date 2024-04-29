//
//
//
//
//  Created by ☮︎ on 3/22/24.
//

import Foundation
import Fluent

struct CreateDepartmentTableMigration: AsyncMigration {
    
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("Departments")
            .id()
            .field("name", .string, .required)
            .field("manager", .uuid)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("Departments")
            .delete()
    }
    
}
