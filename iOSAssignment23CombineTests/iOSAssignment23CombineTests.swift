//
//  iOSAssignment23CombineTests.swift
//  iOSAssignment23CombineTests
//
//  Created by Isaiah Ojo on 05/05/2023.
//


import XCTest
@testable import iOSAssignment23Combine

class MyAppTests: XCTestCase {
    func testFetchPlanets() {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.planets = [
            Planet(name: "Tatooine", climate: "arid", terrain: "desert", population: "200000", residents: [], films: [], imageUrl: nil),
            Planet(name: "Alderaan", climate: "temperate", terrain: "grasslands, mountains", population: "2000000000", residents: [], films: [], imageUrl: nil)
        ]

        let networkManager = NetworkManager()
        let expectation = XCTestExpectation(description: "Fetching planets")
        let testURL = URL(string: "https://example.com/api/planets")!

        mockNetworkService.fetchPlanets(url: testURL) { result in
            switch result {
            case .success(let planets):
                DispatchQueue.main.async {
                    networkManager.planets = planets
                    XCTAssertEqual(networkManager.planets.count, 2)
                    XCTAssertEqual(networkManager.planets[0].name, "Tatooine")
                    XCTAssertEqual(networkManager.planets[1].name, "Alderaan")
                    expectation.fulfill()
                }
            case .failure:
                XCTFail("Error: The fetchPlanets function should return a success result.")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
