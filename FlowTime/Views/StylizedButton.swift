//
//  StylizedButton.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/7/21.
//

import SwiftUI

enum ButtonStyle {
    case capsule
    case circle
    case rectangle
}

struct StylizedButton: View {
    var action: () -> Void
    var systemImage: String?
    var text: String?
    var width: CGFloat
    var height: CGFloat?
    var fill: Bool
    var style: ButtonStyle
    var isActive: Bool
    
    var body: some View {
        switch style {
        case .capsule:
            Button(action: action) {
                HStack {
                    if (systemImage != nil) {
                        Image(systemName: systemImage!)
                            .if(text == nil) {
                                $0.resizable().frame(width: min(width, height ?? .infinity), height: min(width, height ?? .infinity))
                            }
                            .font(Font.body.weight(.light))
                    }
                    if (text != nil) {
                        Text(text!)
                            .fontWeight(.bold)
                            .font(.body)
                    }
                }
                .foregroundColor(fill ? Color("White") : Color("Gray"))
                .frame(width: width, height: height, alignment: .center)
                .padding()
                .background(fill ? AnyView(Capsule().fill(Color("Gray"))) : AnyView(Capsule().stroke(lineWidth: 3).fill(Color("Gray")).opacity(0.3)))
                .disabled(!isActive)
            }
        case .circle:
            Button(action: action) {
                VStack {
                    if (text != nil) {
                        Text(text!)
                            .fontWeight(.bold)
                            .font(.body)
                            
                    }
                    if (systemImage != nil) {
                        Image(systemName: systemImage!)
                            .if(text == nil) {
                                $0.resizable().frame(width: min(width, height ?? .infinity), height: min(width, height ?? .infinity))
                            }
                            .font(Font.body.weight(.light))
                    }
                }
                .foregroundColor(fill ? Color("White") : Color("Gray"))
                .frame(width: width, height: width, alignment: .center)
                .padding()
                .background(fill ? AnyView(Circle().fill(Color("Gray"))) : AnyView(Circle().stroke(lineWidth: 3).fill(Color("Gray")).opacity(0.3)))
                .disabled(!isActive)
            }
        case .rectangle:
            Button(action: action) {
                HStack {
                    if (systemImage != nil) {
                        Image(systemName: systemImage!)
                            .if(text == nil) {
                                $0.resizable().frame(width: min(width, height ?? .infinity), height: min(width, height ?? .infinity))
                            }
                            .font(Font.body.weight(.light))
                    }
                    if (text != nil) {
                        Text(text!)
                            .fontWeight(.bold)
                            .font(.body)
                    }
                }
                .foregroundColor(fill ? Color("White") : Color("Gray"))
                .frame(width: width, height: height, alignment: .center)
                .padding()
                .background(fill ? AnyView(Rectangle().fill(Color("Gray"))) : AnyView(Rectangle().stroke(lineWidth: 3).fill(Color("Gray")).opacity(0.3)))
                .disabled(!isActive)
            }
        }
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        StylizedButton(action: {print("Button Tapped")}, systemImage: "forward.fill" , text: nil, width: UIScreen.main.bounds.width / 4, height: 20, fill: false, style: .capsule, isActive: true)
    }
}
