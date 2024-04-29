//
//  File.swift
//
//
//  Created by ☮︎ on 3/23/24.
//

import Foundation
import Vapor

struct LogMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        print("LOG MIDDLWARE")
        request.headers.add(name: "Access-Control-Allow-Origin", value: "*")
        request.headers.add(name: "Access-Control-Allow-Headers", value: "Content-Type")
        request.headers.add(name: "Access-Control-Allow-Methods", value: "GET, POST, OPTIONS")
        return try await next.respond(to: request)
    }
}
