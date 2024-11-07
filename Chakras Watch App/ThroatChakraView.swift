import SwiftUI
import HealthKit

struct ThroatChakraView: View {
    @State private var vo2Max: Double = 0
    let healthStore = HKHealthStore()

    var body: some View {
        VStack {
            Text("Throat Chakra")
                .font(.headline)
            Text("VO2 Max: \(vo2Max, specifier: "%.2f") mL/kg/min")
                .padding()
        }
        .onAppear(perform: fetchVO2Max)
    }

    func fetchVO2Max() {
        let vo2MaxType = HKQuantityType.quantityType(forIdentifier: .vo2Max)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: vo2MaxType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, results, _ in
            guard let results = results as? [HKQuantitySample], let sample = results.first else { return }
            
            // Utilisation correcte de l'unité mL/kg/min pour VO2 Max
            self.vo2Max = sample.quantity.doubleValue(for: HKUnit.literUnit(with: .milli).unitDivided(by: HKUnit.gramUnit(with: .kilo)).unitDivided(by: HKUnit.minute()))
        }

        healthStore.execute(query)
    }
}
