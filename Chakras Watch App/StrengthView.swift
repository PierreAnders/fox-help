//
//  StrengthView.swift
//  Chakras
//
//  Created by Pierre Untas on 11/11/2024.
//


import SwiftUI
import HealthKit

struct StrengthView: View {
    @State private var activeCalories: Double = 0
    let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            
            PixelIconView(iconName: "hand", primaryColor: .red)
            
            PixelLetterView(text: "C A L O R I E S   A C T I V E S", primaryColor: .white, backgroundColor: .black)
                .padding()
            
            PixelLetterView(text: "\(formatNumber(Int(activeCalories)))   K C A L", primaryColor: .white, backgroundColor: .black)
                           .padding()
            
            Spacer()
        }
        .onAppear(perform: startCaloriesQuery)
    }
    
    func formatNumber(_ number: Int) -> String {
        return String(number).map { String($0) }.joined(separator: " ")
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

#Preview {
    StrengthView()
}
