//
//  WordCell.swift
//  wordsGame
//
//  Created by Andrei Sergienko on 19.12.2022.
//

import SwiftUI

struct WordCell: View {
    
    let word: String
    var body: some View {
        HStack {
            Text(word)
                .foregroundColor(.white)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .font(.custom("AvenirNext-Bold", size: 22))
                .padding()
            Text("\(word.count)")
                .font(.custom("AvenirNext-Bold", size: 22))
                .padding()
                .foregroundColor(.white)
        }
    }
}

struct WordCell_Previews: PreviewProvider {
    static var previews: some View {
        WordCell(word: "Magnit")
    }
}
