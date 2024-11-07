//
//  MainTabView.swift
//  Chakras
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI

struct MainTabView: View {
    @State private var crownValue = 0.0
    private let tabCount = 3

    var body: some View {
        VStack {
            VStack {
                if crownValue < 1 {
                    ContentView()
                } else if crownValue < 2 {
                    CaloriesView()
                } else {
                    RespiratoryRateView()
                }
            }
            .focusable(true)
            .digitalCrownRotation(
                $crownValue,
                from: 0.0,
                through: Double(tabCount - 1),
                by: 1.0,
                sensitivity: .medium,
                isContinuous: false,
                isHapticFeedbackEnabled: true
            )
            .gesture(   
                DragGesture().onEnded { value in
                    let verticalAmount = value.translation.height as CGFloat
                    if verticalAmount < -50 && crownValue < Double(tabCount - 1) {
                        withAnimation(.easeInOut) {
                            crownValue += 1
                        }
                    } else if verticalAmount > 50 && crownValue > 0 {
                        withAnimation(.easeInOut) {
                            crownValue -= 1
                        }
                    }
                }
            )
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

#Preview {
    MainTabView()
}

