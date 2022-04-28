//
//  PassFail.swift
//  Tracklab
//
//  Created by Aneta Cadova on 28.04.2022.
//

import Foundation
import RealmSwift

public class PassFail: Evaluation {
    @Persisted var passFailMin: Double
}
