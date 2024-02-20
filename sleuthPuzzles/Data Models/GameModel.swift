//
//  GameModel.swift
//  sleuthPuzzles
//
//  Created by Justin Lawrence on 2/17/24.
//

import Foundation
import Combine

import SwiftData
import SwiftUI

class GameModel: ObservableObject {
    
    @Published var puzzle = Puzzle()
    
    @Published var timer: Publishers.Autoconnect<Timer.TimerPublisher>? = nil
    var timeLeft = 100
    @Published var testVal = "start"

    init() {
    }
    init(puzzleID: String) {
        if puzzleID == "frozen_wizard" {
            puzzle = WizardDataModel()
        }
    }
    
    func startTimer() {
        testVal = "Now it changed"
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    func getItem(id: String) -> ClueObject? {
        return puzzle.clueItems.first(where: {
            $0.id == id
        })
    }
    func saveItem(item: ClueObject, gameStatus: UserGameStatusModel, context: ModelContext) {
        if !(gameStatus.items ?? []).contains(where: {$0.itemID == item.id}) {
            let newItem = UserItemsInBag(itemID: item.id)
            gameStatus.items?.append(newItem)
            context.insert(newItem)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
            


class Puzzle: ObservableObject {
    var id = ""
    var title: String = "Game"
    var description: String = "Description"
    var timeInGame = 100
    var clueItems: [ClueObject] = []

    init() {
        print("Initing  puzzle")
    }
    func checkCodeValue(code: String, puzzleID: String, gameStatus: UserGameStatusModel, context: ModelContext) -> Bool {
        return false
    }
}
     
