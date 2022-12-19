//
//  ContentView.swift
//  wordsGame
//
//  Created by Andrei Sergienko on 12.12.2022.
//

import SwiftUI

struct StartView: View {
    
    @State var longWord: String = ""
    @State var playerOne: String = ""
    @State var playerTwo: String = ""
    
    @State var isShowedGame: Bool = false
    @State var isAlertPresent: Bool = false
    
    var body: some View {
        VStack {
            
            TitleText(text: "Word Games")
            
            WordTextField(word: $longWord, placeholder: "Enter long word")
                .padding(20)
                .padding(.top, 32)
            
            WordTextField(word: $playerOne, placeholder: "Player one")
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            WordTextField(word: $playerTwo, placeholder: "Player two")
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            Button {
                if longWord.count > 7 {
                    isShowedGame.toggle()
                } else {
                    self.isAlertPresent.toggle()
                }
                
            } label: {
                Text("Start")
                    .font(.custom("Mark-Pro", size: 30))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 64)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(100)
                    .padding(.top)
            }
            
        }.background(Image("background"))
            .alert("Long word is too short!", isPresented: $isAlertPresent, actions: {
                Text("OK")
            })
            .padding()
            .fullScreenCover(isPresented: $isShowedGame) {
                
                let nameOne = playerOne == "" ? "Player one" : playerOne
                let nameTwo = playerTwo == "" ? "Player two" : playerTwo
                
                let playerOne = Player(name: nameOne)
                let playerTwo = Player(name: nameTwo)
                
                let gameViewModel = GameViewModel(playerOne: playerOne, playerTwo: playerTwo, word: longWord)
                
                GameView(viewModel: gameViewModel)
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
