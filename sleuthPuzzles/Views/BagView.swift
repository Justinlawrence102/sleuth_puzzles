//
//  BagView.swift
//  sleuth
//
//  Created by Justin Lawrence on 2/17/24.
//

import SwiftUI
import SwiftData

struct BagView: View {
    @Query private var userItems: [UserItemsInBag]
//    @Binding var userItems: [UserItemsInBag]
    @EnvironmentObject var model: GameModel
    @Environment(\.openWindow) private var openWindow

    init(gameID: String) {
        _userItems = Query(filter: #Predicate<UserItemsInBag> {  $0.game?.puzzleId ==  gameID})

    }
    let rows = [
        GridItem(.fixed(200)),
        GridItem(.fixed(200))
    ]
    var body: some View {
        if userItems.isEmpty {
            VStack{
                Text("No Objects in your bag")
                    .font(.title)
                Text("Look around the map for clues!")
                    .font(.body)
            }
        }else {
            VStack {
                HStack {
                    Text("Bag")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.leading, 40)
                    Spacer()
                }
                Spacer()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(userItems, id: \.self) { item in
                            Button {
                                print("View Object!")
                                openWindow(id: "ClueDetailView", value: item.itemID)
                            } label: {
                                BaggedItemView(userItem: item, clues: model.puzzle.clueItems)
                            }
                            .background(.thinMaterial)
                            .cornerRadius(20)
                            .buttonStyle(.borderless)
                            .buttonBorderShape(.roundedRectangle(radius: 20))
                        }
                    }
                    .padding(.horizontal, 40.0)
                    .frame(height: 430)
                }
            }
            .padding(.vertical, 24)
        }
    }
}

struct Turorial1_Previews: PreviewProvider {
//    @State static var objs = [ClueObject(title: "Map", imageName: "map", color: .red), ClueObject(title: "key", imageName: "key.fill", color: .orange), ClueObject(title: "key2", imageName: "key.fill", color: .green)]
    @State static var objs = [UserItemsInBag(itemID: "1")]
  static var previews: some View {
      BagView(gameID: "frozen_wizard")
          .environmentObject(GameModel())
          .modelContainer(GamesPreviewContainer)
  }
}

struct BaggedItemView: View {
    @State var item: ClueObject
    var hasBeenUsed = false
//    @Environment(\.openWindow) private var openWindow

    init(userItem: UserItemsInBag, clues: [ClueObject]) {
        item = clues.first(where: {$0.id == userItem.itemID}) ?? ClueObject(title: "NULL", imageName: "questionmark", color: .red, view: Text(""))
        hasBeenUsed = userItem.hasBeenUsed
    }
    var body: some View {
        VStack {
            Image(systemName: item.imageName)
#if os(macOS)
                .font(.largeTitle)
#else
                .font(.extraLargeTitle)
#endif
                .foregroundStyle(item.color)
            Text(item.title)
                .font(.title2)
        }
        .frame(width: 200, height: 200)
        .overlay(alignment: .bottomTrailing) {
            if hasBeenUsed {
                Image(systemName: "checkmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(Color("Orange"))
                    .offset(x: 10, y: -10)
            }
        }
    }
}
