//
//  SolarPlexusChakraView.swift
//  Chakras
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI
import HealthKit

struct SolarPlexusChakraView: View {
    @State private var heartRate: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Solar Plexus Chakra")
                .font(.headline)
            Text("Fréquence cardiaque: \(Int(heartRate)) BPM")
                .padding()
        }
        .onAppear(perform: fetchHeartRate)
    }

    func fetchHeartRate() {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, results, _ in
            guard let results = results as? [HKQuantitySample], let sample = results.first else { return }
            self.heartRate = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
        }

        healthStore.execute(query)
    }
}
