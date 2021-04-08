//
//  BadgeWithAction.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/8/21.
//

import SwiftUI

struct BadgeWithAction: View {
    var action: () -> Void
    var badgeText: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Button(action: action) {
            Text(badgeText)
                .font(.system(size: 20, weight: .semibold, design: .default))
                .frame(minWidth: 0, maxWidth: width, minHeight: 0, maxHeight: height)
                .padding()
                .foregroundColor(Color.white)
                .background(Color.red)
                .clipShape(Circle())
        }
    }
}

struct BadgeWithAction_Previews: PreviewProvider {
    static var previews: some View {
        BadgeWithAction(action: {print("badge tapped")}, badgeText: String(0), width: 30, height: 20)
    }
}
