//
//  SOS_Button.swift
//  Hai_Jiran
//
//  Created by stdc user on 02/03/2023.
//

import SwiftUI

struct SOS_Button: View {
    
    @GestureState var tap = false
    @State var press = false
    
    @State private var path: [Int] = []
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    Image(systemName: "sos").font(.system(size: 44, weight: .light))
                        
                    Text("Hold 3 second").foregroundColor(Color.white)
                }
                .foregroundColor(.white)
                .opacity(press ? 0 : 1)
                .scaleEffect(press ? 0 : 1)
                Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                    .font(.system(size: 44, weight: .light))
                    .foregroundColor(Color(.white))
                    .opacity(press ? 1 : 0)
                    .scaleEffect(press ? 1 : 0)
            }
            
            .frame(width: 140, height: 80)
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(press ? .red : .red), Color(press ? .red : .red)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                })
            
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .trim(from: tap ? 0.001 : 1, to: 1)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 70, height: 130)
                    .cornerRadius(20)
                    .rotationEffect(Angle(degrees: 90))
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: 3, y: 3)
                    .animation(.easeInOut)
            )
            
            .shadow(color: Color(press ? .red : .white), radius: 1, x: -1, y: -1)
            .shadow(color: Color(press ? .white : .red), radius: 1, x: 1, y: 1)
            .scaleEffect(tap ? 1.3 : 1)
            .gesture(
                LongPressGesture(minimumDuration: 3).updating($tap) { currentState, gestureState,
                    transaction in
                    gestureState = currentState
                }
                    .onEnded { value in
                        self.press.toggle()
                        isPresented = true
                    }
            )
            
            .navigationDestination(for: Int.self) { value in
                Text("SOS")
            }
            .fullScreenCover(isPresented: $isPresented) {
                SOS_CallAll()
            }
        }
    }
}

struct SOS_Button_Previews: PreviewProvider {
    static var previews: some View {
        SOS_Button()
    }
}
