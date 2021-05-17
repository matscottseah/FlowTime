//
//  ClockHandView.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/3/21.
//

import SwiftUI

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    init(center: CGPoint, radius: CGFloat) {
        self = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    }
}

struct Pointer: Shape {
    var circleRadius: CGFloat = 3
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY - circleRadius))
            p.addEllipse(in: CGRect(center: rect.center, radius: circleRadius))
            p.move(to: CGPoint(x: rect.midX, y: rect.midY + circleRadius))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY + rect.height / 10))
        }
    }
}

struct ClockHandView: View {
    var clockHandAngle: Angle
    var body: some View {
        Pointer()
            .stroke(Color.red, lineWidth: 1.5)
            .rotationEffect(clockHandAngle)
            .padding()
    }
}

struct ClockHandView_Previews: PreviewProvider {
    static var previews: some View {
        ClockHandView(clockHandAngle: Angle.degrees(Double(90) * 360/(60*30)))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
    }
}
