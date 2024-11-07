//
//  SacralChakraView.swift
//  Chakras
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI
import HealthKit

struct SacralChakraView: View {
    @State private var activeCalories: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Sacral Chakra")
                .font(.headline)
            Text("Calories actives: \(Int(activeCalories)) kcal")
                .padding()
        }
        .onAppear(perform: fetchActiveCalories)
    }

    func fetchActiveCalories() {
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else { return }
            self.activeCalories = sum.doubleValue(for: HKUnit.kilocalorie())
        }

        healthStore.execute(query)
    }
}
