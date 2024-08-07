//
//  daweibaApp.swift
//  daweiba
//
//  Created by 潘建勋 on 2024-07-24.
//

import SwiftUI
import SwiftData
import CryptoKit

@main
struct daweibaApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Account.self,
        ])
        #if targetEnvironment(simulator)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        #else
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        #endif

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
