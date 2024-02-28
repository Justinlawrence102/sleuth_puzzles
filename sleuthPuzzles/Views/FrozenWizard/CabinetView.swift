//
//  CabinetView.swift
//  sleuthPuzzles
//
//  Created by Justin Lawrence on 2/27/24.
//

import SwiftUI
import SwiftData

struct CabinetView: View {
    @EnvironmentObject var model: GameModel
    @Environment(\.modelContext) private var context
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss

    @State var number1 = ""
    @State var number2 = ""
    @State var number3 = ""
    @State var number4 = ""
    @Query private var puzzleSolved: [UserPuzzleSolved]

    @State var gameStatus: UserGameStatusModel
    
    init(id: String, puzzleId: String, gameStatus: UserGameStatusModel) {
        _gameStatus = .init(initialValue: gameStatus)
        _puzzleSolved = Query(filter: #Predicate<UserPuzzleSolved> {  $0.id ==  id && $0.game?.puzzleId == puzzleId})
    }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(puzzleSolved.isEmpty ? "Cabinet Lock": "Cabinet")
                    .font(.title2)
                Spacer()
            }
            .padding(.vertical, 15)
            VStack {
                if puzzleSolved.isEmpty {
                    HStack(spacing: 30){
                        TextField("0", text: $number1)
                            .font(.title.weight(.semibold))
//                            .keyboardType(.numberPad)
                            .frame(width: 40, height: 60)
                            .multilineTextAlignment(.center)
                            .background(.thinMaterial)
                            .cornerRadius(8)
                        TextField("0", text: $number2)
                            .font(.title.weight(.semibold))
//                            .keyboardType(.numberPad)
                            .frame(width: 40, height: 60)
                            .multilineTextAlignment(.center)
                            .background(.thinMaterial)
                            .cornerRadius(8)
                        TextField("0", text: $number3)
                            .font(.title.weight(.semibold))
//                            .keyboardType(.numberPad)
                            .frame(width: 40, height: 60)
                            .multilineTextAlignment(.center)
                            .background(.thinMaterial)
                            .cornerRadius(8)
                        TextField("0", text: $number4)
                            .font(.title.weight(.semibold))
//                            .keyboardType(.numberPad)
                            .frame(width: 40, height: 60)
                            .multilineTextAlignment(.center)
                            .background(.thinMaterial)
                            .cornerRadius(8)
                    }
                }else {
                    if let magicBook = model.puzzle.clueItems.first(where: {$0.id == "magic_book"}) {
                        Button(action: {
                            model.saveItem(item: magicBook, gameStatus: gameStatus, context: context)
                            openWindow(id: "ClueDetailView", value: magicBook.id)
                        }, label: {
                            Label(magicBook.title, systemImage: magicBook.imageName)
                                .frame(width: 200, height: 50)
                        })
                        .cornerRadius(28)
                    }
                    if let potionBook = model.puzzle.clueItems.first(where: {$0.id == "potion_book"}) {
                        Button(action: {
                            model.saveItem(item: potionBook, gameStatus: gameStatus, context: context)
                            openWindow(id: "ClueDetailView", value: potionBook.id)
                        }, label: {
                            Label(potionBook.title, systemImage: potionBook.imageName)
                                .frame(width: 200, height: 50)
                        })
                        .cornerRadius(28)
                    }
                }
            }
            .padding()
            .background(Color("Orange"))
            .cornerRadius(12)
            Spacer()
            Image(systemName: puzzleSolved.isEmpty ? "lock.fill" : "lock.open.fill")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.regular)
                .neon(color: .yellow)
        }
        .onChange(of: number1) {
            _ = model.puzzle.checkCodeValue(code: "\(number1)-\(number2)-\(number3)-\(number4)", puzzleID: "cabinet", gameStatus: gameStatus, context: context)
        }
        .onChange(of: number2) {
            _ = model.puzzle.checkCodeValue(code: "\(number1)-\(number2)-\(number3)-\(number4)", puzzleID: "cabinet", gameStatus: gameStatus, context: context)
        }
        .onChange(of: number3) {
            _ = model.puzzle.checkCodeValue(code: "\(number1)-\(number2)-\(number3)-\(number4)", puzzleID: "cabinet", gameStatus: gameStatus, context: context)
        }
        .onChange(of: number4) {
            _ = model.puzzle.checkCodeValue(code: "\(number1)-\(number2)-\(number3)-\(number4)", puzzleID: "cabinet", gameStatus: gameStatus, context: context)
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

//#Preview {
//    CabinetView()
//}
