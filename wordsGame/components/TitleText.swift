//
//  TitleText.swift
//  wordsGame
//
//  Created by Andrei Sergienko on 12.12.2022.
//

import SwiftUI

struct TitleText: View {
    
    @State var text: String = ""
    
    var body: some View {
        Text(text)
            .padding()
            .font(.custom("Mark Pro Bold", size: 42))
            .frame(maxWidth: .infinity)
            .background(Color("FirstPlayer"))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "Magnetotherapy")
    }
}
