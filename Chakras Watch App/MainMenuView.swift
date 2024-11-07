import SwiftUI
import HealthKit

struct MainMenuView: View {
    let healthStore = HKHealthStore()

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    NavigationLink(destination: CrownChakraView()) {
                        ChakraIcon(iconName: "crown.fill", color: .purple) // Crown Chakra
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: ThirdEyeChakraView()) {
                        ChakraIcon(iconName: "eye.fill", color: .indigo) // Third Eye Chakra
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: ThroatChakraView()) {
                        ChakraIcon(iconName: "lungs.fill", color: .blue) // Throat Chakra
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: HeartChakraView()) {
                        ChakraIcon(iconName: "heart.fill", color: .green) // Heart Chakra
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: SolarPlexusChakraView()) {
                        ChakraIcon(iconName: "bolt.fill", color: .yellow) // Solar Plexus Chakra
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: SacralChakraView()) {
                        ChakraIcon(iconName: "flame.fill", color: .orange) // Sacral Chakra
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: RootChakraView()) {
                        ChakraIcon(iconName: "figure.walk", color: .red) // Root Chakra
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .navigationBarTitle("Chakras")
            .onAppear(perform: requestHealthKitAuthorization)
        }
    }

    // Fonction pour demander les autorisations HealthKit
    func requestHealthKitAuthorization() {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
            HKObjectType.quantityType(forIdentifier: .vo2Max)!,
            HKObjectType.categoryType(forIdentifier: .mindfulSession)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { success, error in
            if success {
                print("Autorisation réussie")
            } else if let error = error {
                print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
            }
        }
    }
}

struct ChakraIcon: View {
    var iconName: String
    var color: Color

    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(color)
    }
}
