//
//  WizardMapView.swift
//  sleuth
//
//  Created by Justin Lawrence on 2/17/24.
//

import SwiftUI
import SwiftData

struct WizardMapView: View {
    @EnvironmentObject var model: GameModel
    @Binding var gameStatus: UserGameStatusModel
    @Environment(\.modelContext) private var context
    @Environment(\.openWindow) private var openWindow

    @State var openCabinetSheet = false
    @State var openTableSheet = false
    var body: some View {
        ZStack {
//            BackgroundSfSymbolsView()

            VStack {
                HStack {
                    Text("Map")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.leading, 40)
                    Spacer()
                }
                ZStack {
                    Rectangle()
                        .fill(Color("Purple").opacity(0.3))
                        .stroke(Color("Purple"), lineWidth: 10)
                        .frame(width: 500, height: 350)
                    if let poster = model.getItem(id: "wall_poster") {
                        Button(action: {
                            model.saveItem(item: poster, gameStatus: gameStatus, context: context)
                            openWindow(id: "ClueDetailView", value: poster.id)
                        }, label: {
                            Label(poster.title, systemImage: poster.imageName)
                        })
                        .background(poster.color)
                        .cornerRadius(30)
                        .rotationEffect(Angle(degrees: 270))
                        .offset(x: -250)
                    }
                    Button(action: {
                        openCabinetSheet.toggle()
                    }, label: {
                        Label("Cabinet", systemImage: "cabinet.fill")
                    })
                    .background(.orange)
                    .cornerRadius(30)
                    .offset(x: 160, y: -145)
                    Button(action: {
                        openTableSheet.toggle()
                    }, label: {
                        ZStack {
                            Ellipse()
                                .fill(.gray)
                                .frame(width: 180, height: 100)
                                .cornerRadius(45)
                            Label("Table", systemImage: "table.furniture.fill")
                        }
                    })
                    .frame(width: 160, height: 90)
                    .cornerRadius(45)
                }
                

                Spacer()
            }
            .padding(30)
        }
        .sheet(isPresented: $openCabinetSheet) {
            CabinetView(id: "cabinet", puzzleId: model.puzzle.id, gameStatus: gameStatus)
        }
        .sheet(isPresented: $openTableSheet) {
        
            TableView(gameStatus: gameStatus)
        }
    }
}

struct Wizard_Map_Previews: PreviewProvider {
    @State static var objs = UserGameStatusModel(game: GameModel(puzzleID: "frozen_wizard"))
  static var previews: some View {
      WizardMapView(gameStatus: $objs)
          .modelContainer(GamesPreviewContainer)
          .environmentObject(GameModel(puzzleID: "frozen_wizard"))
  }
}
