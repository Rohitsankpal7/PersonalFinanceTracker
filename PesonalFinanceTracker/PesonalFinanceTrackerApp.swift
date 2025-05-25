//
//  PesonalFinanceTrackerApp.swift
//  PesonalFinanceTracker
//
//  Created by Rohit Sankpal on 25/05/25.
//

import SwiftUI

@main
struct PesonalFinanceTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
