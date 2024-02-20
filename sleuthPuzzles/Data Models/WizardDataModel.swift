//
//  WizardDataModel.swift
//  sleuth
//
//  Created by Justin Lawrence on 2/17/24.
//

import Foundation
import SwiftData
import SwiftUI

class WizardDataModel: Puzzle {
    
    override init() {
        super.init()
        self.title = "Frozen Wizard"
        self.description = "Once upon a time, there was a mighty wizard, but one day he was caught by a trick. Someone switched out his potion book with another. This lead to him getting trapped! He needs your help to unfreeze himself! Everything you need is in his workshop. Good luck!"
        self.timeInGame = 500
        self.id = "frozen_wizard"
        print("Initing  Wizzard Puzzle")

        let wallPoster = ClueObject(id: "wall_poster", title: "Posters", imageName: "newspaper.fill", color: .green, view: PosterClueView())
        let magicBook = ClueObject(id: "magic_book", title: "Magic Book", imageName: "book.fill", color: .orange, view: Text("BOOK!"))
        let potionBook = ClueObject(id: "potion_book", title: "Potion Book", imageName: "book.and.wrench.fill", color: .purple, view: Text("POTION!"))
        self.clueItems = [wallPoster, magicBook, potionBook]
    }
    
    override func checkCodeValue(code: String, puzzleID: String, gameStatus: UserGameStatusModel?, context: ModelContext) -> Bool {
        if puzzleID == "cabinet" {
            if code == "3-5-2-1" {
                let newItem = UserPuzzleSolved(id: puzzleID)
                gameStatus?.puzzlesSolved?.append(newItem)
                if let index = gameStatus?.items?.firstIndex(where: {$0.itemID == "wall_poster"}) {
                    gameStatus!.items![index].hasBeenUsed = true
                }
    
                context.insert(newItem)
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
                return true
            }
        }
        return false
    }
}
            
struct PosterClueView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("3")
                    .offset(x: -20, y: -20)
                    .font(.title)
                Text("5")
                    .offset(x: -15, y: 20)
                    .font(.title)
            }
            .foregroundStyle(Color("Orange"))
            .frame(width: 90, height: 110)
            .background(Color.white)
            VStack {
                Text("2")
                    .offset(x: -20, y: -20)
                    .font(.title)
                Text("1")
                    .offset(x: 20, y: 20)
                    .font(.title)
            }
            .foregroundStyle(Color("Orange"))
            .frame(width: 90, height: 110)
            .background(Color.white)
            .offset(x: 43, y: 0)
            .rotationEffect(Angle(degrees: 17))
            .shadow(radius: 10)
        }
    }
}

#Preview {
    PosterClueView()
}
