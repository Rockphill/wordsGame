//
//  GameViewModel.swift
//  wordsGame
//
//  Created by Andrei Sergienko on 13.12.2022.
//

import Foundation

enum WordError: Error {
    
    case theSameWord
    case beforeWord
    case littleWord
    case wrongWord
    case undefinedError
}

class GameViewModel: ObservableObject {
    
    @Published var playerOne: Player
    @Published var playerTwo: Player
    @Published var words = [String]()
    
    let word: String
    var isFirst = true
    
    init(playerOne: Player, playerTwo: Player, word: String) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.word = word.uppercased()
    }
    
    func validate(word: String) throws {
        
        let word = word.uppercased()
        guard word != self.word else  {
            print("stop")
            throw WordError.theSameWord
        }
        
        guard !(words.contains(word)) else {
            print("make it again")
            throw WordError.beforeWord
        }
        
        guard word.count > 1 else {
            print("very short like your penis")
            throw WordError.littleWord
        }
        
        return
    }
    
    func wordToChars(word: String) -> [Character] {
        
        var chars = [Character]()
        
        for char in word.uppercased() {
            chars.append(char)
        }
        
        return chars
    }
    
    func check(word: String) throws -> Int {
        
        do {
            try self.validate(word: word)
        } catch {
            throw error
        }
        
        
        var bigWordArray = wordToChars(word: self.word)
        let smallWordArray = wordToChars(word: word)
        var result = ""
        
        for char in smallWordArray {
            if bigWordArray.contains(char) {
                result.append(char)
                var i = 0
                while bigWordArray[i] != char {
                    i += 1
                }
                bigWordArray.remove(at: i)
                
            } else {
                throw WordError.wrongWord
            }
        }
        
        guard result == word.uppercased() else {
            print("Unknown error")
            return 0
        }
        
        words.append(result)
        
        if isFirst {
            playerOne.add(score: result.count)
        } else {
            playerTwo.add(score: result.count)
        }
        
        isFirst.toggle()
        
        return result.count
    }
}
