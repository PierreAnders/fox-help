import SwiftUI

struct ProfileView: View {
    // Exemple de données utilisateur
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
                    // Utilisation de PixelLetterView pour afficher le nom en style pixelisé
                    PixelLetterView(text: user.name.uppercased()) // Forcer les majuscules ici
                        .padding(.top, 20)
                    
                    // Liste des caractéristiques avec PixelLetterView pour chaque nom de caractéristique et valeur
                    VStack(spacing: 15) {
                        CharacteristicRow(symbolText: "*", characteristicName: "I n t e l l i g e n c e", value: formatNumber(user.intelligence))
                        CharacteristicRow(symbolText: "^", characteristicName: "E n e r g i e", value: formatNumber(user.energy))
                        CharacteristicRow(symbolText: "^", characteristicName: "F o r c e", value: formatNumber(user.force))
                        CharacteristicRow(symbolText: "^", characteristicName: "C o n s t i t u t i o n", value: formatNumber(user.constitution))
                        CharacteristicRow(symbolText: "^", characteristicName: "A g i l i t e", value: formatNumber(user.agility))
                    }
                    .padding()
                }
            }
        }
    }
    
    // Fonction pour formater les nombres avec un espace entre chaque chiffre
    func formatNumber(_ number: Int) -> String {
        return String(number).map { String($0) }.joined(separator: " ")
    }
}

struct CharacteristicRow: View {
    var symbolText: String
    var characteristicName: String
    var value: String
    
    var body: some View {
        HStack {
            // Utilisation de PixelLetterView pour afficher un symbole personnalisé (par exemple, un cœur)
            PixelLetterView(text: symbolText) // Remplace l'icône par le symbole "^"
                .frame(width: 30, height: 30)
            
            // Utilisation de PixelLetterView pour afficher le nom de la caractéristique en style pixelisé
            PixelLetterView(text: characteristicName.uppercased()) // Forcer les majuscules ici
            
            Spacer()
            
            // Utilisation de PixelLetterView pour afficher la valeur numérique en style pixelisé avec des espaces entre les chiffres
            PixelLetterView(text: value) // Affichage des chiffres en style pixelisé avec espaces
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
