//
//  ClueDetailView.swift
//  sleuthPuzzles
//
//  Created by Justin Lawrence on 2/18/24.
//

import SwiftUI
import SwiftData

struct ClueDetailView: View {
    var objectID: String
    @EnvironmentObject var model: GameModel
    
    @Query private var userItem: [UserItemsInBag]
    
    init(objectID: String, gameID: String){
        self.objectID = objectID
        _userItem = Query(filter: #Predicate<UserItemsInBag> {  $0.game?.puzzleId ==  gameID && $0.itemID == objectID})
    }
    
    var body: some View {
        if let object = model.puzzle.clueItems.first(where: {$0.id == objectID}) {
            VStack {
                Label(object.title, systemImage: object.imageName)
                    .font(.title2)
                Spacer()
                object.view
                Spacer()
                if let object = userItem.first, object.hasBeenUsed {
                    Label("Used", systemImage: "checkmark.circle.fill")
                        .foregroundColor(Color("Orange"))
                }
                
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [object.color, object.color.opacity(0.0), object.color.opacity(0)]), startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

#Preview {
    ClueDetailView(objectID: "wall_poster", gameID: "frozen_wizard")
        .environmentObject(GameModel(puzzleID: "frozen_wizard"))
}
