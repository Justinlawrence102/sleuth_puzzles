//
//  UserGameStatusModel.swift
//  sleuthPuzzles
//
//  Created by Justin Lawrence on 2/17/24.
//

import Foundation
import SwiftData

@Model final class UserGameStatusModel {
    var timeLeft: Int
    var puzzleId: String
    
    @Relationship(deleteRule: .cascade)
    var items:  [UserItemsInBag]?
    
    @Relationship(deleteRule: .cascade)
    var puzzlesSolved:  [UserPuzzleSolved]?
    
    init(gameID: String, timeLeft: Int) {
        self.puzzleId = gameID
        self.timeLeft = timeLeft
        print("Initing  Player \(gameID)")
    }
    init(game: GameModel) {
        self.puzzleId = game.puzzle.id
        self.timeLeft = game.puzzle.timeInGame
    }
}


@Model final class UserItemsInBag {
    var itemID: String
    var hasBeenUsed: Bool = false
    
    @Relationship(inverse: \UserGameStatusModel.items)
    var game: UserGameStatusModel?
    
    init(itemID: String) {
        self.itemID = itemID
    }
}

@Model final class UserPuzzleSolved {
    var id: String
    
    @Relationship(inverse: \UserGameStatusModel.puzzlesSolved)
    var game: UserGameStatusModel?
    
    init(id: String) {
        self.id = id
    }
}
