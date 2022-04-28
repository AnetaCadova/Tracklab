//
//  Exam.swift
//  Tracklab
//
//  Created by Aneta Cadova on 28.04.2022.
//

import Foundation
import RealmSwift

public class Exam: Evaluation {
    @Persisted var lowestE: Double
    @Persisted var lowestD: Double
    @Persisted var lowestC: Double
    @Persisted var lowestB: Double
    @Persisted var lowestA: Double
}
