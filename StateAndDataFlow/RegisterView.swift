//
//  RegisterView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 27.07.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var user: UserManager
    @ObservedObject var textFieldManager = CharCounter()
    @State private var defaults = UserDefaults.standard
    @State private var counter = 0
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter your name...", text: $textFieldManager.userInput)
                    .multilineTextAlignment(.center)
                Text("\(textFieldManager.counter)")
                    .foregroundColor(textFieldManager.color)
                    .font(.title)
            }
            
            Button(action: registerUser) {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text("Ok")
                }
            }
            .disabled(textFieldManager.buttonIsEnabled)

        }
        .padding()
    }
}

extension RegisterView {
    private func registerUser() {
        if !textFieldManager.userInput.isEmpty {
            user.name = textFieldManager.userInput
            defaults.set(true, forKey: "LOGGIN")
            user.isRegister = defaults.bool(forKey: "LOGGIN")
            defaults.set(textFieldManager.userInput, forKey: "Name")
        }

    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(UserManager())
    }
}
