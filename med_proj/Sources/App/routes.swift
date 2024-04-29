import Vapor

func routes(_ app: Application) throws {
    
    app.middleware.use(LogMiddleware())
    
    // POST routes to create new items
    app.post("department") { req -> EventLoopFuture<Department> in
        let department = try req.content.decode(Department.self)
        return department.create(on: req.db).map { department }
    }

    app.post("employee") { req -> EventLoopFuture<Employee> in
        let employee = try req.content.decode(Employee.self)
        return employee.create(on: req.db).map { employee }
    }
    
    app.post("project") { req -> EventLoopFuture<Project> in
        let project = try req.content.decode(Project.self)
        return project.create(on: req.db).map { project }
    }
    
    // GET routes to fetch all items
    app.get("department") { req async throws in
        try await Department.query(on: req.db).all()
    }

    app.get("employee") { req -> EventLoopFuture<[Employee]> in
        let sortBy: String? = req.query["sortBy"]
        var query = Employee.query(on: req.db)
        if let sortBy = sortBy {
            switch sortBy {
                case "name":
                    query = query.sort(\.$name, .ascending)
                case "title":
                    query = query.sort(\.$title, .ascending)
                default:
                    break
            }
        }
        return query.all()
    }

    app.get("project") { req async throws in
        let sortBy: String? = req.query["sortBy"]
        var query = Project.query(on: req.db)
        if let sortBy = sortBy {
            switch sortBy {
                case "startDate":
                    query = query.sort(\.$startDate, .ascending)
                case "endDate":
                    query = query.sort(\.$endDate, .ascending)
                case "budget":
                    query = query.sort(\.$endDate, .ascending)
                default: 
                    break
            }
        }
        return try await query.all()
    }

    
    // DELETE routes to delete items by ID
    app.delete("department", ":id") { req -> EventLoopFuture<HTTPStatus> in
        let departmentID = try req.parameters.require("id", as: UUID.self)
        return Department.find(departmentID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { department in
                department.delete(on: req.db).transform(to: .noContent)
            }
    }
    
    app.delete("employee", ":id") { req -> EventLoopFuture<HTTPStatus> in
        let employeeID = try req.parameters.require("id", as: UUID.self)
        return Employee.find(employeeID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { employee in
                employee.delete(on: req.db).transform(to: .noContent)
            }
    }
    
    app.delete("project", ":id") { req -> EventLoopFuture<HTTPStatus> in
        let projectID = try req.parameters.require("id", as: UUID.self)
        return Project.find(projectID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { project in
                project.delete(on: req.db).transform(to: .noContent)
            }
    }
    
    // PUT routes to update items by ID
    app.put("department", ":id") { req -> EventLoopFuture<Department> in
        let departmentID = try req.parameters.require("id", as: UUID.self)
        return Department.find(departmentID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { department -> EventLoopFuture<Department> in // Add `throws` here
                do {
                    let updatedDepartment = try req.content.decode(Department.self)
                    department.name = updatedDepartment.name
                    department.manager = updatedDepartment.manager
                    // Update other attributes as needed
                    return department.update(on: req.db).map { department }
                } catch {
                    return req.eventLoop.makeFailedFuture(error)
                }
            }
    }

    app.put("employee", ":id") { req -> EventLoopFuture<Employee> in
        let employeeID = try req.parameters.require("id", as: UUID.self)
        return Employee.find(employeeID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { employee -> EventLoopFuture<Employee> in // Add `throws` here
                do {
                    let updatedEmployee = try req.content.decode(Employee.self)
                    employee.name = updatedEmployee.name
                    employee.title = updatedEmployee.title
                    employee.home_dept = updatedEmployee.home_dept
                    // Update other attributes as needed
                    return employee.update(on: req.db).map { employee }
                } catch {
                    return req.eventLoop.makeFailedFuture(error)
                }
            }
    }

    app.put("project", ":id") { req -> EventLoopFuture<Project> in
        let projectID = try req.parameters.require("id", as: UUID.self)
        return Project.find(projectID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { project -> EventLoopFuture<Project> in // Add `throws` here
                do {
                    let updatedProject = try req.content.decode(Project.self)
                    project.name = updatedProject.name
                    project.startDate = updatedProject.startDate
                    project.endDate = updatedProject.endDate
                    project.budget = updatedProject.budget
                    project.sponsor = updatedProject.sponsor
                    // Update other attributes as needed
                    return project.update(on: req.db).map { project }
                } catch {
                    return req.eventLoop.makeFailedFuture(error)
                }
            }
    }

}
