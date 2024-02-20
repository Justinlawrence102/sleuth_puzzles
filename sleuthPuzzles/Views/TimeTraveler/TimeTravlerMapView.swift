//
//  TimeTravlerMapView.swift
//  sleuthPuzzles
//
//  Created by Justin Lawrence on 2/18/24.
//

import Foundation
import SwiftUI

struct TimeTravlerMapView: View {
    @EnvironmentObject var model: GameModel
    @State var gameStatus: UserGameStatusModel?
    @Environment(\.modelContext) private var context

    var body: some View {
        VStack {
            Text(model.puzzle.title)
            ForEach(model.puzzle.clueItems, id: \.self) { item in
                Button(action: {
                    let newItem = UserItemsInBag(itemID: item.id)
                    gameStatus?.items?.append(newItem)
                    context.insert(newItem)
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }, label: {
                    Label(item.title, systemImage: item.imageName)
                        .tint(item.color)
                })
                
            }
            Spacer()
            Button(action: {
                model.startTimer()
            }, label: {
                Label("Start Game", systemImage: "timer")
            })
        }
        .padding()
    }
}

#Preview {
    TimeTravlerMapView()
}
