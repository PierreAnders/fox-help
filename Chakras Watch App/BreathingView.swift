//
//  BreathingView.swift
//  Chakras
//
//  Created by Pierre Untas on 13/11/2024.
//

import SwiftUI
import HealthKit

struct BreathingView: View {
    @State private var averageRespirationRate: Double = 0
    let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            
            PixelIconView(iconName: "lungs", primaryColor: .blue)
            
            PixelLetterView(text: "R E S P I R A T I O N   M O Y E N N E", primaryColor: .white, backgroundColor: .black)
                .padding()
            
            PixelLetterView(text: "\(formatRespiration(averageRespirationRate)) B P M", primaryColor: .white, backgroundColor: .black)
                .padding()
            
            Spacer()
        }
        .onAppear(perform: fetchAverageRespirationRate)
    }
    
    func formatRespiration(_ rate: Double) -> String {
        return String(format: "%.1f", rate)
    }
    
    func fetchAverageRespirationRate() {
        let respirationType = HKQuantityType.quantityType(forIdentifier: .respiratoryRate)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: respirationType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, _ in
            if let result = result, let average = result.averageQuantity() {
                self.averageRespirationRate = average.doubleValue(for: HKUnit(from: "count/min"))
            }
        }
        
        healthStore.execute(query)
    }
}

#Preview {
    BreathingView()
}
