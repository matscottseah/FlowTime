//
//  RoundedButton.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/8/21.
//

import SwiftUI

struct RoundedButton: View {
    var action: () -> Void
    var buttonText: String
    var width: CGFloat
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .fontWeight(.bold)
                .font(.body)
                .frame(minWidth: 0, maxWidth: width)
                .padding()
                .foregroundColor(Color("White"))
                .background(Color("Gray"))
                .cornerRadius(40)
        }
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(action: {print("rounded button tapped")},
                      buttonText: "Text",
                      width: 100)
    }
}
