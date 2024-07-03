//
//  SwiftDataObserverTestApp.swift
//  SwiftDataObserverTest
//
//  Created by Robert Hahn on 03.07.24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataObserverTestApp: App {
	/// Persistence container to the Model Container
	@MainActor
	static var persistent: ModelContainer {
		let schema = Schema([
			Item.self,
		])
		let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
		
		do {
			let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
			return container
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
		.modelContainer(Self.persistent)
    }
}
