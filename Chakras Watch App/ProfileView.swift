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
                        CharacteristicRow(symbolText: "lightning", characteristicName: " E n e r g i e", value: formatNumber(user.energy), primaryColor: .yellow)
                        CharacteristicRow(symbolText: "book", characteristicName: " I n t e l l i g e n c e", value: formatNumber(user.intelligence), primaryColor: .blue)
                        CharacteristicRow(symbolText: "hand", characteristicName: " F o r c e", value: formatNumber(user.force), primaryColor: .red)
                        CharacteristicRow(symbolText: "heart", characteristicName: " C o n s t i t u t i o n", value: formatNumber(user.constitution), primaryColor: .green)
                        CharacteristicRow(symbolText: "boot", characteristicName: " A g i l i t e", value: formatNumber(user.agility), primaryColor: .purple)
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

struct CharacteristicRow: View {
    var symbolText : String
    var characteristicName : String
    var value : String
    
    // Ajout de paramètres pour les couleurs personnalisées
    var primaryColor : Color = .white
    
    var body : some View{
        HStack{
            // Passer les mêmes couleurs à PixelIconView et PixelLetterView
            PixelIconView(iconName : symbolText , primaryColor : primaryColor )
                .frame(width : 30 , height : 30 )
            
            PixelLetterView(text : characteristicName.uppercased())
            
            Spacer()
            
            PixelLetterView(text : value , primaryColor : primaryColor )
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
    }
}

// Modèle utilisateur pour stocker les caractéristiques
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
