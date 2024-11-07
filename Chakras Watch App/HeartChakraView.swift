//
//  HeartChakraView.swift
//  Chakras
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI
import HealthKit

struct HeartChakraView: View {
    @State private var heartRateVariability: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Heart Chakra")
                .font(.headline)
            Text("Variabilité cardiaque: \(heartRateVariability, specifier: "%.2f") ms")
                .padding()
        }
        .onAppear(perform: fetchHeartRateVariability)
    }

    func fetchHeartRateVariability() {
        let hrvType = HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: hrvType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, results, _ in
            guard let results = results as? [HKQuantitySample], let sample = results.first else { return }
            self.heartRateVariability = sample.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli))
        }

        healthStore.execute(query)
    }
}
