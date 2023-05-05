//
//  NetworkableProtocol.swift
//  iOSAssignment23Combine
//
//  Created by Isaiah Ojo on 05/05/2023.
//

import Foundation

protocol NetworkService {
    func fetchPlanets(url: URL, completion: @escaping (Result<[Planet], Error>) -> Void)
}
