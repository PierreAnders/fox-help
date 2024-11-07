//
//  RespiratoryRateView.swift
//  Chakras
//
//  Created by Pierre Untas on 07/11/2024.
//

import SwiftUI
import HealthKit

struct RespiratoryRateView: View {
    @State private var respiratoryRate: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Fréquence")
                .font(.headline)
            Text("Respiratoire")
                .font(.headline)
            Text("\(respiratoryRate, specifier: "%.1f") /min")
                .padding()
        }
        .onAppear(perform: startRespiratoryRateQuery)
    }

    func startRespiratoryRateQuery() {
        let respiratoryRateType = HKQuantityType.quantityType(forIdentifier: .respiratoryRate)!
        
        healthStore.requestAuthorization(toShare: nil, read: [respiratoryRateType]) { success, error in
            if success {
                let query = HKAnchoredObjectQuery(type: respiratoryRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error) in
                    updateRespiratoryRate(samples)
                }
                
                query.updateHandler = { (query, samples, deletedObjects, anchor, error) in
                    updateRespiratoryRate(samples)
                }
                
                healthStore.execute(query)
            }
        }
    }

    func updateRespiratoryRate(_ samples: [HKSample]?) {
        guard let respiratorySamples = samples as? [HKQuantitySample] else { return }
        guard let sample = respiratorySamples.first else { return }

        let respiratoryUnit = HKUnit(from: "count/min")
        let rateValue = sample.quantity.doubleValue(for: respiratoryUnit)

        DispatchQueue.main.async {
            self.respiratoryRate = rateValue
        }
    }
}

struct RespiratoryRateView_Previews: PreviewProvider {
    static var previews: some View {
        RespiratoryRateView()
    }
}
