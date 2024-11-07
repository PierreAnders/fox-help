//
//  CrownChakraView.swift
//  Chakras
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI
import HealthKit

struct CrownChakraView: View {
    @State private var sleepMinutes: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Crown Chakra")
                .font(.headline)
            Text("Temps de sommeil: \(Int(sleepMinutes)) min")
                .padding()
        }
        .onAppear(perform: fetchSleepAnalysis)
    }

    func fetchSleepAnalysis() {
        let sleepType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 0, sortDescriptors: nil) { _, results, _ in
            guard let results = results as? [HKCategorySample] else { return }
            let totalSleepTime = results.reduce(0) { (sum, sample) -> Double in
                if sample.value == HKCategoryValueSleepAnalysis.asleepUnspecified.rawValue {
                    return sum + sample.endDate.timeIntervalSince(sample.startDate) / 60.0
                }
                return sum
            }
            self.sleepMinutes = totalSleepTime
        }

        healthStore.execute(query)
    }
}
