//
//  ContentView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 27.07.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var timer = TimeCounter()
    @EnvironmentObject var user: UserManager
    @State private var defaults = UserDefaults.standard
    @State private var name = UserDefaults.standard.object(forKey: "Name") as? String ?? ""

    var body: some View {
        VStack {
            Text("Hi, \(name)")
                .font(.largeTitle)
                .offset(x: 0, y: 100)
            Text("\(timer.counter)")
                .font(.largeTitle)
                .offset(x: 0, y: 200)
            Spacer()
            
            VStack {
                ButtonView(timer: timer)
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserManager())
    }
}

struct ButtonView: View {
    @ObservedObject var timer: TimeCounter
    @EnvironmentObject var user: UserManager
    @State private var defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            Button(action: { self.timer.startTemer() }) {
                Text("\(timer.buttonTitle)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            .frame(width: 200, height: 60)
            .background(Color.red)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.black, lineWidth: 4)
            )
                .padding(.top, 150)

            
            Button(action: logOut) {
                Text("LOG OUT")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            .frame(width: 200, height: 60)
            .background(Color.blue)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.black, lineWidth: 4)
            )
                .padding(.top, 150)
        }
    }
}

extension ButtonView {
    private func logOut() {
        user.isRegister = false
        defaults.removeObject(forKey: "LOGGIN")
        defaults.set(false, forKey: "LOGGIN")
    }
}
