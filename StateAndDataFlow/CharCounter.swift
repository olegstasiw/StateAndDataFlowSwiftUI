//
//  CharCounter.swift
//  StateAndDataFlow
//
//  Created by mac on 29.07.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Combine
import SwiftUI

class CharCounter: ObservableObject {
    let objectWillChange = PassthroughSubject<CharCounter, Never>()
    var counter = 0
    var buttonIsEnabled = true
    var color = Color.red


 @Published var userInput = "" {
     didSet {
        if userInput.count > counter{
            counter += 1
            objectWillChange.send(self)
        } else {
            counter -= 1
            objectWillChange.send(self)
        }
        if userInput.count > 2 {
            buttonIsEnabled = false
            color = Color.green
        } else {
            buttonIsEnabled = true
            color = Color.red
        }
     }
 }
}
