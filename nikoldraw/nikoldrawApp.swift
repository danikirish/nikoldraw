//
//  nikoldrawApp.swift
//  nikoldraw
//
//  Created by Daniyar Irishev on 30/05/2021.
//

import SwiftUI

@main
struct nikoldrawApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
