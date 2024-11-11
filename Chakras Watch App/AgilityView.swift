//
//  AgilityView.swift
//  Chakras
//
//  Created by Pierre Untas on 11/11/2024.
//

import SwiftUI
import HealthKit

struct AgilityView: View {
    @State private var stepCount: Double = 0
    let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            
            PixelIconView(iconName: "boot", primaryColor: .purple)
            
            PixelLetterView(text: "N O M B R E   D E   P A S", primaryColor: .white, backgroundColor: .black)
                .padding()
            
            PixelLetterView(text: "\(formatNumber(Int(stepCount)))   P A S", primaryColor: .white, backgroundColor: .black)
                .padding()
            
            Spacer()
        }
        .onAppear(perform: fetchStepCount)
    }
    
    func formatNumber(_ number: Int) -> String {
        return String(number).map { String($0) }.joined(separator: " ")
    }
    
    func fetchStepCount() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else { return }
            self.stepCount = sum.doubleValue(for: HKUnit.count())
        }
        
        healthStore.execute(query)
    }
}

#Preview {
    AgilityView()
}
