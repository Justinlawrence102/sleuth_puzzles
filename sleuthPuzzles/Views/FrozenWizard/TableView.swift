//
//  TableView.swift
//  sleuthPuzzles
//
//  Created by Justin Lawrence on 2/27/24.
//

import SwiftUI
import SwiftData

struct TableView: View {
    @EnvironmentObject var model: GameModel
    @Environment(\.modelContext) private var context
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    
    @State var gameStatus: UserGameStatusModel

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Table")
                    .font(.title2)
                Spacer()
            }
            Spacer()
                .frame(height: 30)
            if let note = model.puzzle.clueItems.first(where: {$0.id == "note_clue"}) {
                Button(action: {
                    model.saveItem(item: note, gameStatus: gameStatus, context: context)
                    openWindow(id: "ClueDetailView", value: note.id)
                }, label: {
                    Label(note.title, systemImage: note.imageName)
                        .frame(width: 200, height: 50)
                        .foregroundStyle(note.color)
                })
                .cornerRadius(28)
            }
            Spacer()
        }
        .overlay(alignment: .topTrailing) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 5, height: 15)
            })
            .background(Color("Pink"))
            .cornerRadius(30)
        }
        .padding()
    }
}
