//
//  PlusButton.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/7/21.
//

import SwiftUI

struct PlusButton: View {
    var action: () -> Void
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: width, height: height)
                .font(Font.title.weight(.ultraLight))
                .foregroundColor(Color("Gray"))
        }
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton(action: {print("Plus one")}, width: 100, height: 100)
    }
}
