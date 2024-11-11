import SwiftUI

struct ProfileView: View {

    var user: User = User(
        name: "P i e r r e   U n t a s",
        intelligence: 75,
        energy: 85,
        force: 90,
        constitution: 80,
        agility: 70
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Utilisation de PixelLetterView avec des couleurs personnalisées pour le nom
                    PixelLetterView(text: user.name.uppercased(), primaryColor: .gray, backgroundColor: .black)
                        .padding(.top, 20)
                    
                    VStack(spacing: 15) {
                        // Passer des couleurs personnalisées à PixelIconView et PixelLetterView
                        CharacteristicRow(symbolText: "lightning", characteristicName: " E n e r g i e", value: formatNumber(user.energy), primaryColor: .yellow, destinationView: EnergyView())
                        CharacteristicRow(symbolText: "book", characteristicName: " I n t e l l i g e n c e", value: formatNumber(user.intelligence), primaryColor: .blue, destinationView: IntelligenceView())
                        CharacteristicRow(symbolText: "hand", characteristicName: " F o r c e", value: formatNumber(user.force), primaryColor: .red, destinationView: StrengthView())
                        CharacteristicRow(symbolText: "heart", characteristicName: " V I T A L I T E", value: formatNumber(user.constitution), primaryColor: .green, destinationView: VitalityView())
                        CharacteristicRow(symbolText: "boot", characteristicName: " A g i l i t e", value: formatNumber(user.agility), primaryColor: .purple, destinationView: AgilityView())
                    }
                    .padding()
                }
            }
        }
//        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func formatNumber(_ number: Int) -> String {
        return String(number).map { String($0) }.joined(separator: " ")
    }
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
            // Passer les mêmes couleurs à PixelIconView et PixelLetterView
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
