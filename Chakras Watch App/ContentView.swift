import SwiftUI

struct PixelArtView: View {
    let pixelSize: CGFloat = 3

      let colors: [[Color]] = [
        [.clear, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .brown, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .brown, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .brown, .black, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .black, .brown, .brown, .white, .brown, .brown, .brown, .brown, .brown, .brown, .white, .brown, .brown, .black, .black, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .black, .black, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .black, .black, .black, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .black, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .white, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .white, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .brown, .brown, .brown, .black, .black, .white, .white, .white, .white, .white, .white, .white, .black, .black, .brown, .brown, .brown, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .white, .white, .white, .brown, .brown, .brown, .black, .white, .white, .black, .black, .white, .white, .white, .white, .black, .white, .white, .black, .brown, .brown, .brown, .brown, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear],
        [.clear, .white, .white, .brown, .brown, .brown, .brown, .brown, .black, .black, .black, .black, .black, .white, .white, .white, .white, .black, .black, .black, .black, .brown, .brown, .brown, .brown, .brown, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear],
        [.clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear],
        [.clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .black, .black],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black],
        [.clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .black],
        [.clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .black],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .black, .black, .black, .black, .black, .black, .black, .black, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .black, .black, .black, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .brown, .brown, .white, .white, .brown, .brown, .brown, .brown, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .brown, .brown, .brown, .brown, .brown, .brown, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .brown, .clear, .clear, .brown, .brown, .brown, .clear, .white, .white, .white, .white, .white, .brown, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .brown, .clear, .clear, .clear, .brown, .clear, .white, .white, .white, .white, .brown, .brown, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .brown, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .brown, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .brown, .brown, .clear, .clear, .clear, .white, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .brown, .clear, .clear, .clear, .white, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .brown, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .brown, .clear, .clear, .clear, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .brown, .clear, .clear, .clear, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .brown, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<colors.count) { row in
                HStack(spacing: 0) {
                    ForEach(0..<colors[row].count) { col in
                        Rectangle()
                            // Applique la couleur du tableau à chaque rectangle
                            .fill(colors[row][col])
                            // Définit la taille de chaque "pixel"
                            .frame(width: pixelSize,
                                   height: pixelSize)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        PixelArtView()
            // Ajuste la taille globale du dessin en fonction des besoins
            .frame(width: 100,
                   height: 100)
            // Centrer l'avatar dans l'interface
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
