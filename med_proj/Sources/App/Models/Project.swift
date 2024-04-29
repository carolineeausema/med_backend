//
//  Project
//
//
//  Created by ☮︎ on 3/24/24.
//

import Foundation
import Fluent
import Vapor

final class Project: Model, Content {
    init() { }
    
    static let schema: String = "Projects"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "start_date")
    var startDate: String
    
    @Field(key: "end_date")
    var endDate: String
    
    @Field(key: "budget")
    var budget: String
    
    @Field(key: "sponsor")
    var sponsor: UUID?
    
    init(id: UUID? = nil, name: String, startDate: String, endDate: String, budget: String, sponsor: UUID? = nil) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.budget = budget
        self.sponsor = sponsor
    }
}
