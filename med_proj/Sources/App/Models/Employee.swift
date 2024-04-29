//
//  Employee
//  
//
//  Created by ☮︎ on 3/24/24.
//

import Foundation
import Fluent
import Vapor

final class Employee: Model, Content {
    init() { }
    
    
    static let schema: String = "Employees"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "home_dept")
    var home_dept: Department.IDValue
    
    init(id: UUID? = nil, name: String, title: String, home_dept: UUID) {
        self.id = id
        self.name = name
        self.title = title
        self.home_dept = home_dept
    }
}
