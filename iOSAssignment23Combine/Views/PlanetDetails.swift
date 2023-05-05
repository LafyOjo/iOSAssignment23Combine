//
//  PlanetDetails.swift
//  iOSAssignment23Combine
//
//  Created by Isaiah Ojo on 05/05/2023.
//

import Foundation
import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet

    var body: some View {
        VStack(alignment: .leading) {
            Text(planet.name)
                .font(.largeTitle)
                .bold()
            Text("Climate: \(planet.climate)")
            Text("Terrain: \(planet.terrain)")
            Text("Population: \(planet.population)")
            // Fetch and display data from nested APIs, like residents and films
        }
        .padding()
    }
}
