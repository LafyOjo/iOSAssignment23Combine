//
//  iOSAssignment23CombineApp.swift
//  iOSAssignment23Combine
//
//  Created by Isaiah Ojo on 05/05/2023.
//

import SwiftUI

@main
struct iOSAssignment23CombineApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
