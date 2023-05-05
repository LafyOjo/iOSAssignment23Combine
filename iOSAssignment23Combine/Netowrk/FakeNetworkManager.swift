//
//  FakeNetworkManager.swift
//  iOSAssignment23Combine
//
//  Created by Isaiah Ojo on 05/05/2023.
//

import Foundation
import SwiftUI

class MockNetworkService: NetworkService {
    var planets: [Planet] = []

    func fetchPlanets(url: URL, completion: @escaping (Result<[Planet], Error>) -> Void) {
        completion(.success(planets))
    }
}
