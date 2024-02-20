//
//  FrozenWizardTabView.swift
//  sleuth
//
//  Created by Justin Lawrence on 2/17/24.
//

import SwiftUI
import SwiftData

struct GameTabView: View {
    @Environment(\.modelContext) private var context
    @State var gameStatus: UserGameStatusModel?
    @State var isShowingGameInfo = false
    @EnvironmentObject var model: GameModel
    @Query private var userItems: [UserItemsInBag]
    var gameID: String
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State var isShowingClock = false
    
    var body: some View {
        TabView {
            if gameID == "frozen_wizard" {
                WizardMapView(gameStatus: gameStatus)
                    .tabItem {
                        Label("Map", systemImage: "map.fill")
                    }
            }else if gameID == "time_traveler" {
                TimeTravlerMapView(gameStatus: gameStatus)
                    .navigationTitle("Map")
                    .tabItem {
                        Label("Map", systemImage: "map.fill")
                    }
            }
            BagView(gameID: model.puzzle.id)
                .badge(gameStatus?.items?.count ?? 0)
                .tabItem {
                    Label("Bag", systemImage: "bag.fill")
                }
            Text("HELP!")
                .tabItem {
                    Label("Help", systemImage: "questionmark.circle.fill")
                }
        }
        .onAppear{
            if gameID == "frozen_wizard" {
                model.puzzle = WizardDataModel()
                
            }else if gameID == "time_traveler" {
                model.puzzle = TimeTravelerDataModel()
            }
            if gameStatus == nil {
                print("Create new game")
                let newGame = UserGameStatusModel(game: model)// UserGameStatusModel(gameID: "frozen_wizard", timeLeft: 500)
                gameStatus = newGame
                context.insert(gameStatus!)
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
                //                try? context.save()
            }else {
                print("Exisiting game! \(gameStatus!.timeLeft)")
                print(gameStatus!.puzzleId)
                model.timeLeft = gameStatus!.timeLeft
            }
            //            model.test() //= WizardDataModel()
            isShowingGameInfo.toggle()
        }
        .onDisappear{
#if os(visionOS)
            dismissWindow(id: "TimerView")
#endif
            print("Time Left: \(model.timeLeft)")
            gameStatus!.timeLeft = model.timeLeft
            print("Saving: \(gameStatus!.timeLeft)")
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        .sheet(isPresented: $isShowingGameInfo) {
            VStack {
                Text(model.puzzle.title)
                    .font(.title)
                Text(model.puzzle.description)
                    .lineLimit(20)
                    .font(.body)
                Spacer()
                HStack {
                    if gameStatus?.timeLeft != 0 {
                        Button(action: {
                            print("Start")
                            isShowingGameInfo.toggle()
                            model.startTimer()
#if os(visionOS)
                            openWindow(id: "TimerView")
#endif
                        }, label: {
                            Text(gameStatus?.timeLeft == model.puzzle.timeInGame ? "Start Game" : "Resume")
                        })
                    }
                    if gameStatus?.timeLeft != model.puzzle.timeInGame {
                        Button(action: {
                            isShowingGameInfo.toggle()
                            gameStatus!.timeLeft = model.puzzle.timeInGame //= UserGameStatusModel(game: model)
                            model.timeLeft = model.puzzle.timeInGame
                            model.startTimer()
                            print("Resaving time \(gameStatus!.timeLeft)")
                            do {
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            do {
                                let puzzleID = model.puzzle.id
                                try context.delete(model: UserItemsInBag.self, where: #Predicate<UserItemsInBag> { $0.game?.puzzleId == puzzleID}, includeSubclasses: false)
                                try context.delete(model: UserPuzzleSolved.self, where: #Predicate<UserPuzzleSolved> { $0.game?.puzzleId == puzzleID}, includeSubclasses: false)
                            }catch {
                                print("COULDN't DELETE")
                            }
                            
#if os(visionOS)
                            openWindow(id: "TimerView")
#endif
                            
                        }, label: {
                            Text("Restart Game")
                        })
                    }
                }
            }
            .frame(height: 230)
            .padding()
        }
#if os(iOS)
        .toolbar {
            Button(action: {
                isShowingClock.toggle()
            }, label: {
                Image(systemName: "clock")
            })
        }
        .sheet(isPresented: $isShowingClock) {
            TimerView()
        }
#endif
    }
}

#Preview {
    GameTabView(gameID: "frozen_wizard")
        .environmentObject(GameModel())
        .modelContainer(GamesPreviewContainer)
}
