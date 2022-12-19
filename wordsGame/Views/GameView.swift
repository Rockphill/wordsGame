//
//  GameView.swift
//  wordsGame
//
//  Created by Andrei Sergienko on 12.12.2022.
//

import SwiftUI

struct GameView: View {
    
    @State private var word: String = ""
    var viewModel: GameViewModel
    @State private var confirmPresent: Bool = false
    @State private var isAlertPresent: Bool = false
    @State var alertText: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Button {
                    confirmPresent.toggle()
                } label: {
                    Text("Exit")
                        .padding(6)
                        .padding(.horizontal)
                        .background(Color("Purple"))
                        .cornerRadius(12)
                        .padding(6)
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
                }
                Spacer()
            }
            
            Text(viewModel.word)
                .font(.custom("AvenirNext-Bold", size: 36))
                .foregroundColor(.white)
            
            HStack(spacing: 12) {
                
                VStack {
                    Text("\(viewModel.playerOne.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    
                    Text("\(viewModel.playerOne.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(20)
                    .shadow(color: viewModel.isFirst ? .blue : .clear, radius: 20)
                
                VStack {
                    Text("\(viewModel.playerTwo.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    
                    Text("\(viewModel.playerTwo.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("SecondPlayer"))
                    .cornerRadius(20)
                    .shadow(color: viewModel.isFirst ? .clear : .green, radius: 20)
                
            }
            
            WordTextField(word: $word, placeholder: "Your word")
                .padding(.horizontal)
            
            Button {
                
                var score = 0
                
                do {
                    try score = viewModel.check(word: word)
                } catch WordError.beforeWord {
                    alertText = "Think, you need new word, not previous word"
                    isAlertPresent.toggle()
                } catch WordError.littleWord {
                    alertText = "Very short like your penis, if you don't have penis it's your problem, sorry"
                    isAlertPresent.toggle()
                } catch WordError.theSameWord {
                    alertText = "Think, it was before"
                    isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "This word can't be create"
                    isAlertPresent.toggle()
                } catch {
                    alertText = "Undefined error"
                    isAlertPresent.toggle()
                }
                
                if score > 0 {
                    self.word = ""
                }
            } label: {
                Text("Done")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("Purple"))
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            List {
                ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                        .listRowInsets(EdgeInsets())
                }
                
            }.listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            
        }.background(Image("background"))
            .confirmationDialog("Are you sure?",
                                isPresented: $confirmPresent,
                                titleVisibility: .visible) {
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("YES")
                }
                
                Button() { } label: {
                    Text("NO")
                }
            }
                                .alert(alertText,
                                       isPresented: $isAlertPresent) {
                                    Text("OK")
                                }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(playerOne: Player(name: "John"),
                                          playerTwo: Player(name: "McClane"), word: "DickYourMom"))
    }
}
