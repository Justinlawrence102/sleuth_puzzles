//
//  ContentView.swift
//  sleuth
//
//  Created by Justin Lawrence on 2/17/24.
//

import SwiftUI
import SwiftData
//import RealityKit
//import RealityKitContent

struct HomeView: View {
    @EnvironmentObject var model: GameModel

    @Query var userStatus: [UserGameStatusModel]

    init() {
        _userStatus = Query()
    }
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundSfSymbolsView()
                VStack {
                    //            Model3D(named: "Scene", bundle: realityKitContentBundle)
                    //                .padding(.bottom, 50)
                    //            Spacer()
                    VStack {
                        Text("Sleuth Escape Rooms")
#if os(macOS)
                            .font(.largeTitle)
#else
                            .font(.extraLargeTitle2)
#endif
                            .fontDesign(.rounded)
                            .fontWeight(.semibold)
                            .neon(color: Color("Orange"))
                        Image(systemName: "key")
#if os(macOS)
                            .font(.largeTitle)
#else
                            .font(.extraLargeTitle2)
#endif
                            .fontDesign(.rounded)
                            .fontWeight(.regular)
                            .neon(color: .yellow)
                    }
                    .padding(.top, 50)
                    
                    
                    Spacer()
                    Text("Select a game:")
                    
                    NavigationLink(destination: {
                        GameTabView(gameStatus: userStatus.first(where: {$0.puzzleId == "frozen_wizard"}) ?? UserGameStatusModel(), gameID: "frozen_wizard")
                    }, label: {
                        Text("Frozen Wizard")
                            .frame(width: 300, height: 55)
                    })
                    .background(Color("Pink"))
                    .cornerRadius(28)
                    
                    NavigationLink(destination: {
                        GameTabView(gameStatus: userStatus.first(where: {$0.puzzleId == "time_traveler"}) ?? UserGameStatusModel(), gameID: "time_traveler")
                    }, label: {
                        Text("Time Traveler")
                            .frame(width: 300, height: 55)
                    })
                    .background(Color("Pink"))
                    .cornerRadius(28)
                    .padding(.bottom, 50)
                    Text("More Coming Soon!")
                        .foregroundStyle(.secondary)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("Purple"), Color("Purple").opacity(0.4), Color("Purple").opacity(0)]), startPoint: .top, endPoint: .bottom)
                )
            }
        }
    }
}

#Preview() {
//    windowStyle: .automatic
    HomeView()
        .environmentObject(GameModel())
        .modelContainer(GamesPreviewContainer)
}

struct NeonStyle: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        content
            .foregroundColor(color).brightness(0.3)
            .shadow(color: color, radius: 10, x: 0, y: 0)
    }
}

extension View {
    func neon(color: Color) -> some View {
        modifier(NeonStyle(color: color))
    }
}

struct BackgroundSfSymbolsView: View {
    var body: some View {
        ZStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 150))
                .offset(x: 120, y: -60)
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .offset(x: -420, y: 230)
            Image(systemName: "questionmark")
                .font(.system(size: 60))
                .offset(x: -290, y: 120)
            Image(systemName: "questionmark")
                .font(.system(size: 190))
                .offset(x: 390, y: -150)
            Image(systemName: "questionmark")
                .font(.system(size: 100))
                .offset(x: -420, y: -190)
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 70))
                .offset(x: -240, y: -120)
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 120))
                .offset(x: 330, y: 120)
            Image(systemName: "lock.fill")
                .font(.system(size: 50))
                .offset(x: 440, y: 240)
            Image(systemName: "timer")
                .font(.system(size: 50))
                .offset(x: -440, y: 30)
        }
        .foregroundStyle(Color("Purple").opacity(0.18))
    }
}
