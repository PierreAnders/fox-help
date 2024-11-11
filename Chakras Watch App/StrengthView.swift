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
        
        // Demander l'autorisation d'accéder aux calories actives
        healthStore.requestAuthorization(toShare: nil, read: [calorieType]) { success, error in
            if success {
                // Si l'autorisation est accordée, lancer la requête pour récupérer les calories actives
                fetchActiveCalories()
            } else if let error = error {
                print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
            }
        }
    }

    func fetchActiveCalories() {
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        // Obtenir la date du début de la journée actuelle
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        // Créer un prédicat pour filtrer les données d'aujourd'hui
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        // Créer une requête HKStatisticsQuery pour obtenir la somme des calories actives
        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            
            if let error = error {
                print("Erreur lors de la récupération des calories actives : \(error.localizedDescription)")
                return
            }
            
            // Vérifier si des résultats ont été trouvés et calculer la somme
            if let result = result, let sum = result.sumQuantity() {
                let activeCaloriesValue = sum.doubleValue(for: HKUnit.kilocalorie())
                
                // Mettre à jour l'interface utilisateur sur le thread principal
                DispatchQueue.main.async {
                    self.activeCalories = activeCaloriesValue
                }
            } else {
                print("Aucune donnée trouvée.")
            }
        }
        
        // Exécuter la requête
        healthStore.execute(query)
    }
}

#Preview {
    StrengthView()
}
