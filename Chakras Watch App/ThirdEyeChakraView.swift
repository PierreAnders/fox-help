//
//  ThirdEyeChakraView.swift
//  Chakras
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI
import HealthKit

struct ThirdEyeChakraView: View {
    @State private var meditationMinutes: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Third Eye Chakra")
                .font(.headline)
            Text("Temps de méditation: \(Int(meditationMinutes)) min")
                .padding()
        }
        .onAppear(perform: fetchMeditationTime)
    }

    func fetchMeditationTime() {
        let meditationType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: meditationType, predicate: predicate, limit: 0, sortDescriptors: nil) { _, results, _ in
            guard let results = results as? [HKCategorySample] else { return }
            let totalMeditationTime = results.reduce(0) { (sum, sample) -> Double in
                return sum + sample.endDate.timeIntervalSince(sample.startDate) / 60.0
            }
            self.meditationMinutes = totalMeditationTime
        }

        healthStore.execute(query)
    }
}
