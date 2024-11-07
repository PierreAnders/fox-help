//
//  RootChakraView.swift
//  Chakras
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI
import HealthKit

struct RootChakraView: View {
    @State private var stepCount: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Root Chakra")
                .font(.headline)
            Text("Pas quotidiens: \(Int(stepCount))")
                .padding()
        }
        .onAppear(perform: fetchStepCount)
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
