import SwiftUI
import HealthKit

struct ContentView: View {
    let healthStore = HKHealthStore()
    
    var body: some View {
        NavigationView { // Ajout du NavigationView pour gérer la navigation
            VStack {
                Spacer().frame(height: 40)
                
                // PixelArtView devient cliquable grâce à NavigationLink
                NavigationLink(destination: ProfileView()) {
                    PixelArtView()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 30)
                }
                .buttonStyle(PlainButtonStyle())
                
                PixelLetterView(text: "H I   F O L K S")
                    .frame(width: 100, height: 30)
            }
            .onAppear(perform: requestHealthKitAuthorization)
        }
    }
        
    func requestHealthKitAuthorization() {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
            HKObjectType.quantityType(forIdentifier:.vo2Max)!,
            HKObjectType.categoryType(forIdentifier:.mindfulSession)!,
            HKObjectType.categoryType(forIdentifier:.sleepAnalysis)!
        ]

        healthStore.requestAuthorization(toShare:nil, read :healthKitTypesToRead) { success,error in
            if success{
               print("Autorisation réussie")
           } else if let error=error{
               print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
           }
       }
   }
}

#Preview{
   ContentView()
}
