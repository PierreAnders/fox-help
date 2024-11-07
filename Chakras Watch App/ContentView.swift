//
//  ContentView.swift
//  Chakras Watch App
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var heartRate: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Fréquence Cardiaque")
                .font(.headline)
            Text("\(Int(heartRate)) BPM")
                .font(.largeTitle)
                .padding()
        }
        .onAppear(perform: startHeartRateQuery)
    }

    func startHeartRateQuery() {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        healthStore.requestAuthorization(toShare: nil, read: [heartRateType]) { success, error in
            if success {
                let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error) in
                    updateHeartRate(samples)
                }
                
                query.updateHandler = { (query, samples, deletedObjects, anchor, error) in
                    updateHeartRate(samples)
                }
                
                healthStore.execute(query)
            }
        }
    }

    func updateHeartRate(_ samples: [HKSample]?) {
        guard let heartRateSamples = samples as? [HKQuantitySample] else { return }
        guard let sample = heartRateSamples.first else { return }

        let heartRateUnit = HKUnit(from: "count/min")
        let heartRateValue = sample.quantity.doubleValue(for: heartRateUnit)

        DispatchQueue.main.async {
            self.heartRate = heartRateValue
        }
    }
}

#Preview {
    ContentView()
}
