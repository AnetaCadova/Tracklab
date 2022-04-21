//
//  DataStructs.swift
//  Tracklab
//
//  Created by Aneta Cadova on 18.04.2022.
//

import Foundation

struct User : Encodable, Decodable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let password: String
}

struct Semester : Encodable, Decodable{
    let id: Int
    let name: String
    let userId: Int
}

struct Subject : Encodable, Decodable {
    let id: Int
    let name: String
    let code: String
    let credits: Int
    let evaluationId: Int
    let goal: String
    let currentPoint: Double
    let semesterId: Int
    let userId: Int
}

struct Task : Encodable, Decodable {
    let id: Int
    let name: String
    let maxPoints: Int
    let goal: Double
    let currentPoint: Double
    let dueDate: Date
    let subjectId: Int
    let userId: Int
}

protocol Evaluation : Encodable, Decodable {
    var id: Int { get set }
    var name: String { get set }
    var maxPoints: Double { get set }
    var userId: Int { get set }
}

// Common Implementation using protocol extension
extension Evaluation {
    static func parseEvaluationFields(jsonDict: [String: Any]) -> (Int, String, Double, Int) {
        let id = jsonDict["id"] as! Int
        let name = jsonDict["name"] as! String
        let maxPoints = jsonDict["maxPoints"] as! Double
        let userId = jsonDict["userId"] as! Int

        return (id, name, maxPoints, userId)
    }
}

struct PassFail: Evaluation, Encodable, Decodable {
    var id: Int
    var name: String
    var maxPoints: Double
    var userId: Int
    let passFailMin: Double
    init(jsonDict: [String: Any]) {
        (id, name, maxPoints, userId) = PassFail.parseEvaluationFields(jsonDict: jsonDict)
        passFailMin = jsonDict["passFailMin"] as! Double
    }
}

struct Exam: Evaluation, Encodable, Decodable  {
    var id: Int
    var name: String
    var maxPoints: Double
    var userId: Int
    let lowestE: Double
    let lowestD: Double
    let lowestC: Double
    let lowestB: Double
    let lowestA: Double
    init(jsonDict: [String: Any]) {
        (id, name, maxPoints, userId) = Exam.parseEvaluationFields(jsonDict: jsonDict)
        lowestE = jsonDict["lowestE"] as! Double
        lowestD = jsonDict["lowestD"] as! Double
        lowestC = jsonDict["lowestC"] as! Double
        lowestB = jsonDict["lowestB"] as! Double
        lowestA = jsonDict["lowestA"] as! Double
    }
}
