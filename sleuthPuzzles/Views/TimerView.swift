//
//  TimerView.swift
//  sleuthPuzzles
//
//  Created by Justin Lawrence on 2/17/24.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var model: GameModel
    @State var timeLeft = 0
    var body: some View {
        VStack {
            Text("Time Remaining")
                .font(.system(.extraLargeTitle2, design: .rounded))
                .fontWeight(.semibold)
                .neon(color: Color("Orange"))
            
            if let timer = model.timer {
            Label("\(timeLeft)", systemImage: "clock.fill")
                .font(.system(.extraLargeTitle2))
                    .onReceive(timer) { _ in
                        if model.timeLeft > 0 {
                            model.timeLeft -= 1
                            timeLeft -= 1
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("Purple"), Color("Purple").opacity(0.4), Color("Purple").opacity(0)]), startPoint: .top, endPoint: .bottom))
        .onAppear() {
            timeLeft = model.timeLeft
        }
    }
}
#Preview {
    TimerView()
        .environmentObject(GameModel())
}
