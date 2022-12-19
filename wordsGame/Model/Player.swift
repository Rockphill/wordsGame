//
//  Player.swift
//  wordsGame
//
//  Created by Andrei Sergienko on 13.12.2022.
//

import Foundation

struct Player {
    
    let name: String
    private(set) var score = 0
    
    mutating func add(score: Int) {
        self.score += score
    }
}
