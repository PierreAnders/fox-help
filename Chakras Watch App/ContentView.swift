import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 40)
            
            PixelArtView() // Votre image pixelisée
                .frame(width: 100, height: 100)
                .padding(.bottom, 30)
            
            PixelTitleView()
                .frame(width: 100, height: 30)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
