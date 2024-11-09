//
//  ChakrasApp.swift
//  Chakras Watch App
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI


@main
struct Chakras_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
//            MainMenuView()
            PixelLetterView(text: "A B C D E F G H I")
            PixelLetterView(text: "J K L M N O P Q R")
            PixelLetterView(text: "S T U V W X Y Z")
            PixelLetterView(text: "1 2 3 4 5 6 7 8 9 0")
        }
    }
}
