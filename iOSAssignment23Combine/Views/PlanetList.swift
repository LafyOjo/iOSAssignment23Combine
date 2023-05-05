//
//  PlanetList.swift
//  iOSAssignment23Combine
//
//  Created by Isaiah Ojo on 05/05/2023.
//

import Foundation
import SwiftUI

struct PlanetListView: View {
    @ObservedObject private var networkManager = NetworkManager()
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: searchText) { query in
                        if query.isEmpty {
                            let defaultURL = URL(string: "https://swapi.dev/api/planets/")!
                            networkManager.fetchPlanets(completion: { result in
                                switch result {
                                case .success(let planets):
                                    DispatchQueue.main.async {
                                        networkManager.planets = planets
                                    }
                                case .failure(let error):
                                    print("Error fetching planets:", error)
                                }
                            }, url: defaultURL)
                        } else {
                            networkManager.searchQuery = query
                        }
                    }
                
                List(networkManager.planets) { planet in
                    NavigationLink(destination: PlanetDetailView(planet: planet)) {
                        HStack {
                            if let imageUrl = planet.imageUrl {
                                AsyncImage(url: imageUrl)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                            } else {
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(planet.name)
                                    .font(.headline)
                            }
                        }
                    }
                }
                .onAppear {
                    let defaultURL = URL(string: "https://swapi.dev/api/planets/")!
                    networkService.fetchPlanets(completion: { result in
                        switch result {
                        case .success(let planets):
                            DispatchQueue.main.async {
                                networkManager.planets = planets
                            }
                        case .failure(let error):
                            print("Error fetching the planets:", error)
                        }
                    }, url: defaultURL)
                }
                .navigationTitle("Planets")
            }
        }
    }
}
