import SwiftUI
import HealthKit

struct VitalityView: View {
    @State private var totalCalories: Double = 0
    let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            
            PixelIconView(iconName: "heart", primaryColor: .green)
            
            PixelLetterView(text: "C A L O R I E S   T O T A L E S", primaryColor: .white, backgroundColor: .black)
                .padding()
            
            PixelLetterView(text: "\(formatNumber(Int(totalCalories)))   K C A L", primaryColor: .white, backgroundColor: .black)
                           .padding()
            
            Spacer()
        }
        .onAppear(perform: startCaloriesQuery)
    }
    
    func formatNumber(_ number: Int) -> String {
        return String(number).map { String($0) }.joined(separator: " ")
    }
    
    func startCaloriesQuery() {
        let activeCalorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let basalCalorieType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        
        let typesToRead = Set([activeCalorieType, basalCalorieType])
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if success {
                // Query for active and basal energy burned
                let activeQuery = HKAnchoredObjectQuery(type: activeCalorieType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error) in
                    updateCalories(samples, isActiveCalories: true)
                }
                
                let basalQuery = HKAnchoredObjectQuery(type: basalCalorieType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error) in
                    updateCalories(samples, isActiveCalories: false)
                }
                
                activeQuery.updateHandler = { (query, samples, deletedObjects, anchor, error) in
                    updateCalories(samples, isActiveCalories: true)
                }
                
                basalQuery.updateHandler = { (query, samples, deletedObjects, anchor, error) in
                    updateCalories(samples, isActiveCalories: false)
                }
                
                healthStore.execute(activeQuery)
                healthStore.execute(basalQuery)
            }
        }
    }

    func updateCalories(_ samples: [HKSample]?, isActiveCalories: Bool) {
        guard let calorieSamples = samples as? [HKQuantitySample] else { return }

        let calorieUnit = HKUnit.kilocalorie()
        let caloriesValue = calorieSamples.reduce(0) { sum, sample in
            return sum + sample.quantity.doubleValue(for: calorieUnit)
        }

        DispatchQueue.main.async {
            if isActiveCalories {
                self.totalCalories += caloriesValue // Ajoute les calories actives
            } else {
                self.totalCalories += caloriesValue // Ajoute les calories basales (repos)
            }
        }
    }
}

#Preview {
    VitalityView()
}
