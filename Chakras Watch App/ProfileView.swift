import SwiftUI
import HealthKit

struct ProfileView: View {
    @AppStorage("userName") var userName: String = "" // Récupère le nom sauvegardé ou vide par défaut
    @State private var intelligence: Double = 0 // Minutes de respiration (mindful sessions)
    @State private var energy: Double = 0 // Minutes de sommeil
    @State private var force: Double = 0 // Calories actives
    @State private var constitution: Double = 0 // Calories basales
    @State private var agility: Double = 0 // Nombre de pas
    let healthStore = HKHealthStore()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Affichage du nom de l'utilisateur ou "Choisir un nom" si non défini
                    NavigationLink(destination: NameCreationView()) {
                        PixelLetterView(
                            text: (userName.isEmpty ? "Choisir un Nom" : userName).uppercased()
                        )
                        .padding(.top, 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    VStack(spacing: 15) {
                        CharacteristicRow(symbolText: "lightning", characteristicName: " E n e r g i e", value: formatNumber(Int(energy)), primaryColor: .purple, destinationView: EnergyView()) // Minutes de sommeil ici
                        CharacteristicRow(symbolText: "book", characteristicName: " I n t e l l i g e n c e", value: formatNumber(Int(intelligence)), primaryColor: .blue, destinationView: IntelligenceView()) // Minutes de respiration ici
                        CharacteristicRow(symbolText: "heart", characteristicName: " V I T A L I T E", value: formatNumber(Int(constitution)), primaryColor: .green, destinationView: VitalityView())
                        CharacteristicRow(symbolText: "boot", characteristicName: " A g i l i t e", value: formatNumber(Int(agility)), primaryColor: .yellow, destinationView: AgilityView())
                        CharacteristicRow(symbolText: "hand", characteristicName: " F o r c e", value: formatNumber(Int(force)), primaryColor: .orange, destinationView: StrengthView())
                    }
                    .padding()
                }
            }
        }
        .onAppear(perform: requestHealthData) // Demande d'autorisation HealthKit à l'apparition de la vue.
    }
    
    func formatNumber(_ number: Int) -> String {
        return String(number).map { String($0) }.joined(separator: " ")
    }

    // Fonction pour demander l'autorisation et récupérer les données HealthKit
    func requestHealthData() {
        let typesToRead = Set([
            HKObjectType.quantityType(forIdentifier:.activeEnergyBurned)!,
            HKObjectType.categoryType(forIdentifier:.mindfulSession)!, // Sessions de respiration (intelligence)
            HKObjectType.quantityType(forIdentifier:.stepCount)!,
            HKObjectType.quantityType(forIdentifier:.basalEnergyBurned)!,
            HKObjectType.categoryType(forIdentifier:.sleepAnalysis)! // Sommeil (energy)
        ])
        
        healthStore.requestAuthorization(toShare:nil, read :typesToRead) { success, error in
            if success {
                fetchHealthData()
            } else if let error = error {
                print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
            }
        }
    }

    // Fonction pour récupérer les données spécifiques depuis HealthKit
    func fetchHealthData() {
        fetchActiveCalories()
        fetchMindfulMinutes() // Récupérer les minutes de respiration (intelligence)
        fetchStepCount()
        fetchBasalCalories()
        fetchSleepMinutes() // Récupérer les minutes de sommeil (energy)
    }

    // Exemple de récupération des calories actives (force)
    func fetchActiveCalories() {
        let calorieType = HKQuantityType.quantityType(forIdentifier:.activeEnergyBurned)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now,options :.strictStartDate)
        
        let query=HKStatisticsQuery(quantityType :calorieType,quantitySamplePredicate :predicate,options :.cumulativeSum) { _,result,error in
            
            if let error=error{
                print("Erreur lors de la récupération des calories actives : \(error.localizedDescription)")
                return
            }
            
            if let result=result,let sum=result.sumQuantity(){
                let activeCaloriesValue=sum.doubleValue(for :.kilocalorie())
                
                DispatchQueue.main.async{
                    self.force=activeCaloriesValue
                }
            }
        }
        
        healthStore.execute(query)
    }

    // Récupération des minutes totales de sommeil (energy)
    func fetchSleepMinutes() {
        let sleepAnalysis = HKCategoryType.categoryType(forIdentifier:.sleepAnalysis)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for :now)
        
        let predicate = HKQuery.predicateForSamples(withStart:startOfDay,end :now,options:.strictStartDate)
        
        let query = HKSampleQuery(sampleType:sleepAnalysis,predicate :predicate,limit :0,sortDescriptors:nil){ _,samples,error in
            
            if let error = error {
                print("Erreur lors de la récupération des données sur le sommeil : \(error.localizedDescription)")
                return
            }
            
            guard let samples=samples as? [HKCategorySample] else{return}
            
            DispatchQueue.main.async{
                self.energy=samples.reduce(0.0){sum,sample in sum+sample.endDate.timeIntervalSince(sample.startDate)/60.0}
            }
        }
        
        healthStore.execute(query)
    }

    // Récupération des minutes de respiration (intelligence)
    func fetchMindfulMinutes() {
        let mindfulType = HKCategoryType.categoryType(forIdentifier:.mindfulSession)!
        
        let now=Date()
        let startOfDay=Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now,options :.strictStartDate)
        
        let query=HKSampleQuery(sampleType :mindfulType,predicate :predicate,limit :HKObjectQueryNoLimit,sortDescriptors:nil){ _,samples,error in
            
            if let error=error{
                print("Erreur lors de la récupération des minutes de respiration : \(error.localizedDescription)")
                return
            }
            
            guard let samples=samples as? [HKCategorySample] else{
                print("Aucun échantillon trouvé.")
                return
            }
            
            DispatchQueue.main.async{
                self.intelligence=samples.reduce(0.0){ sum,sample in sum+sample.endDate.timeIntervalSince(sample.startDate)/60.0}
            }
        }
        
        healthStore.execute(query)
    }

    // Exemple de récupération du nombre de pas (agilité)
    func fetchStepCount(){
        let stepCountType=HKQuantityType.quantityType(forIdentifier :.stepCount)!
        
        let now=Date()
        let startOfDay=Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now,options :.strictStartDate)
        
        let query=HKStatisticsQuery(quantityType :stepCountType ,quantitySamplePredicate :predicate ,options :.cumulativeSum){ _,result,error in
            
            if let error=error{
                print("Erreur lors de la récupération du nombre de pas : \(error.localizedDescription)")
                return
            }
            
            if let result=result,let sum=result.sumQuantity(){
                DispatchQueue.main.async{
                    self.agility=sum.doubleValue(for :.count())
                }
            }
        }
        
        healthStore.execute(query)
    }

    // Exemple de récupération des calories basales (constitution)
    func fetchBasalCalories(){
        let basalCalorieType=HKQuantityType.quantityType(forIdentifier :.basalEnergyBurned)!
        
        let now=Date()
        let startOfDay=Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now,options :.strictStartDate)
        
        let query=HKStatisticsQuery(quantityType :basalCalorieType ,quantitySamplePredicate :predicate ,options :.cumulativeSum){ _,result,error in
            
            if let error=error{
                print("Erreur lors de la récupération des calories basales : \(error.localizedDescription)")
                return
            }
            
            if let result=result,let sum=result.sumQuantity(){
                DispatchQueue.main.async{
                    self.constitution=sum.doubleValue(for :.kilocalorie())
                }
            }
        }
        
        healthStore.execute(query)
    }
}

#Preview{
   ProfileView()
}

struct CharacteristicRow<Destination>: View where Destination : View {
    var symbolText : String
    var characteristicName : String
    var value : String
    
    // Ajout de paramètres pour les couleurs personnalisées
    var primaryColor : Color = .white
    
    // Vue de destination pour la navigation
    var destinationView : Destination?
    
    var body : some View{
       HStack{
           if let destination = destinationView {
               NavigationLink(destination : destination) {
                   rowContent
               }
               .buttonStyle(PlainButtonStyle())
           } else {
               rowContent
           }
       }
       .padding()
       .background(Color.gray.opacity(0.3))
       .cornerRadius(10)
   }

   // Contenu de la ligne (icône + texte + valeur)
   private var rowContent : some View {
       HStack{
           PixelIconView(iconName : symbolText , primaryColor : primaryColor )
               .frame(width : 30 , height : 30 )
           PixelLetterView(text : characteristicName.uppercased())
           Spacer()
           PixelLetterView(text : value , primaryColor : primaryColor )
       }
   }
}

struct User {
   var name: String
   var intelligence: Int
   var energy: Int
   var force: Int
   var constitution: Int
   var agility: Int
}

#Preview {
   ProfileView()
}
