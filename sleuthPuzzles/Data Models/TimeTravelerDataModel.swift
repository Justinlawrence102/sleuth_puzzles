//
//  TimeTravelerDataModel.swift
//  sleuthPuzzles
//
//  Created by Justin Lawrence on 2/18/24.
//

import Foundation

class TimeTravelerDataModel: Puzzle {
    
    override init() {
        super.init()
        self.title = "Time Traveler"
        self.description = "Have not written yet!"
        self.timeInGame = 250
        self.id = "time_traveler"
        
//        let clock = ClueObject(title: "Clock", imageName: "clock.fill", color: .gray)
//        let lightning = ClueObject(title: "Storm", imageName: "cloud.bolt.fill", color: .yellow)
//        self.clueItems = [clock, lightning]
        self.clueItems = []
    }
}
      
