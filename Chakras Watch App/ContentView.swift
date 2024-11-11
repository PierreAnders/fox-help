import SwiftUI

struct ContentView: View {
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
        }
    }
}

#Preview {
    ContentView()
}
