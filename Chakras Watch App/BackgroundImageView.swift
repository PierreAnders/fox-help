import SwiftUI

struct ImageView: View {
    var body: some View {
        VStack {
            // Afficher l'image
            Image("fox-pic")
                .resizable() // Permet à l'image de changer de taille
                .scaledToFit() // Garde les proportions et ajuste l'image à la vue
                .frame(width: 150, height: 150) // Taille de l'image (ajustez selon vos besoins)
            
            // Texte pour vérifier que la vue fonctionne
            Text("Image affichée")
                .font(.headline)
                .padding()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
