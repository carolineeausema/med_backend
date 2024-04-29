//
//  Department
//
//
//  Created by ☮︎ on 3/24/24.
//

import Foundation
import Fluent
import Vapor

final class Department: Model, Content {
    init() { }
    
    
    static let schema: String = "Departments"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "manager")
    var manager: UUID?
    
    init(id: UUID? = nil, name: String, manager: UUID? = nil) {
        self.id = id
        self.name = name
        self.manager = manager
    }
}
