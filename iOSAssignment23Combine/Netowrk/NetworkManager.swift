//
//  NetworkManager.swift
//  iOSAssignment23Combine
//
//  Created by Isaiah Ojo on 05/05/2023.
//

import Foundation
import Combine

class NetworkManager: NetworkService, ObservableObject {
    func fetchPlanets(url: URL, completion: @escaping (Result<[Planet], Error>) -> Void) {
         
    }
    
    
    @Published var planets: [Planet] = []
    @Published var searchQuery: String = ""
    @Published var error: Error?

    var searchQueryCancellable: AnyCancellable?
    var cancellables: Set<AnyCancellable> = []

    init() {
        searchQueryCancellable = $searchQuery
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .compactMap { [weak self] _ in self?.searchURL() }
            .sink { [weak self] url in
                self?.fetchPlanets(completion: { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let planets):
                            self?.planets = planets
                        case .failure(let error):
                            self?.error = error
                        }
                    }
                }, url: url)
            }
    }

    func fetchPlanets(completion: @escaping (Result<[Planet], Error>) -> Void, url: URL) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PlanetList.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            } receiveValue: { planetList in
                completion(.success(planetList.results))
                print(planetList)
            }
            .store(in: &cancellables)
    }

    func searchURL() -> URL? {
        guard !searchQuery.isEmpty else { return nil }
        return URL(string: "https://swapi.dev/api/planets/?search=\(searchQuery)")
    }
    
    func search(query: String) {
            let filteredPlanets = planets.filter { planet in
                planet.name.lowercased().contains(query.lowercased())
            }
            planets = filteredPlanets
        }
}
