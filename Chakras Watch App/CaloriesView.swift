//
//  CaloriesView.swift
//  Chakras
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI
import HealthKit

struct CaloriesView: View {
    @State private var activeCalories: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Calories Actives")
                .font(.headline)
            Text("\(Int(activeCalories)) kcal")
                .padding()
        }
        .onAppear(perform: startCaloriesQuery)
    }

    func startCaloriesQuery() {
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        healthStore.requestAuthorization(toShare: nil, read: [calorieType]) { success, error in
            if success {
                let query = HKAnchoredObjectQuery(type: calorieType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error) in
                    updateCalories(samples)
                }
                
                query.updateHandler = { (query, samples, deletedObjects, anchor, error) in
                    updateCalories(samples)
                }
                
                healthStore.execute(query)
            }
        }
    }

    func updateCalories(_ samples: [HKSample]?) {
        guard let calorieSamples = samples as? [HKQuantitySample] else { return }
        guard let sample = calorieSamples.first else { return }

        let calorieUnit = HKUnit.kilocalorie()
        let caloriesValue = sample.quantity.doubleValue(for: calorieUnit)

        DispatchQueue.main.async {
            self.activeCalories = caloriesValue
        }
    }
}
