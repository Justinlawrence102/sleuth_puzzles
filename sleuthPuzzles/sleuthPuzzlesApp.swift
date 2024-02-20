//
//  sleuthPuzzlesApp.swift
//  sleuthPuzzles
//
//  Created by Justin Lawrence on 2/17/24.
//

import SwiftUI
import SwiftData

@main
struct sleuthPuzzlesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserGameStatusModel.self,
            UserItemsInBag.self,
            UserPuzzleSolved.self
        ])

        do {
            return try ModelContainer(for: schema, configurations: [])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @ObservedObject var model = GameModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(model)
        }
        .modelContainer(sharedModelContainer)
#if os(visionOS)
        WindowGroup(id: "TimerView") {
            TimerView()
                .environmentObject(model)
        }
        .defaultSize(width: 150, height: 100)
        
        WindowGroup(id: "ClueDetailView", for: String.self) { $objectID in
            if let objectID {
                ClueDetailView(objectID: objectID, gameID: model.puzzle.id)
                    .environmentObject(model)
            }
        }
        .modelContainer(sharedModelContainer)
        .defaultSize(width: 300, height: 300)
#endif
    }
}

@MainActor
let GamesPreviewContainer: ModelContainer = {
    do {
        
        let container = try ModelContainer(for: UserGameStatusModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        let game = UserGameStatusModel(gameID: "frozen_wizard", timeLeft: 500)
        container.mainContext.insert(game)
        
        let obj = UserItemsInBag(itemID: "test_for_now")
        obj.game = game
        container.mainContext.insert(obj)
        
        let puzzlesFinished = UserPuzzleSolved(id: "cabinet")
        obj.game = game
        container.mainContext.insert(puzzlesFinished)
        
        return container
    } catch {
        fatalError ("Failed to create container")
    }
}( )
