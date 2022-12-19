//
//  WordTextField.swift
//  wordsGame
//
//  Created by Andrei Sergienko on 12.12.2022.
//

import SwiftUI

struct WordTextField: View {
    
    @State var word: Binding<String>
    var placeholder: String
    
    var body: some View {
        
        TextField(placeholder, text: word)
            .font(.title2)
            .padding()
            .background(.white)
            .cornerRadius(10)
        
    }
}
