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
        
        // Demander l'autorisation d'accéder aux données HealthKit
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if success {
                // Si l'autorisation est accordée, lancer les requêtes pour récupérer les calories
                fetchTotalCalories()
            } else if let error = error {
                print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
            }
        }
    }

    func fetchTotalCalories() {
        let activeCalorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let basalCalorieType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        
        // Obtenir la date du début de la journée actuelle
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        // Requête pour les calories actives
        let activeQuery = HKStatisticsQuery(quantityType: activeCalorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            
            if let error = error {
                print("Erreur lors de la récupération des calories actives : \(error.localizedDescription)")
                return
            }
            
            var activeCaloriesValue = 0.0
            if let result = result, let sum = result.sumQuantity() {
                activeCaloriesValue = sum.doubleValue(for: HKUnit.kilocalorie())
            }
            
            // Requête pour les calories basales (repos)
            let basalQuery = HKStatisticsQuery(quantityType: basalCalorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                
                if let error = error {
                    print("Erreur lors de la récupération des calories basales : \(error.localizedDescription)")
                    return
                }
                
                var basalCaloriesValue = 0.0
                if let result = result, let sum = result.sumQuantity() {
                    basalCaloriesValue = sum.doubleValue(for: HKUnit.kilocalorie())
                }
                
                // Mettre à jour l'interface utilisateur avec le total des calories (actives + basales)
                DispatchQueue.main.async {
                    self.totalCalories = activeCaloriesValue + basalCaloriesValue
                }
            }
            
            // Exécuter la requête pour les calories basales après avoir récupéré les calories actives
            healthStore.execute(basalQuery)
        }
        
        // Exécuter la requête pour les calories actives
        healthStore.execute(activeQuery)
    }
}

#Preview {
    VitalityView()
}
