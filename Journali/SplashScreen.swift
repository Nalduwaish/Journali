import SwiftUI

struct SplashScreen: View {
    // Controls when to switch to the main page
    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                // Show your real main page here
                MainPage()
            } else {
                VStack {
                    Image("Journali logo")
                        .resizable()
                        .frame(width: 77.7, height: 101)
                        .padding(24.23)

                    Text("Journali")
                        .font(.system(size: 42, weight: .black))
                        .padding(11)

                    Text("Your thoughts, your story")
                        .font(.system(size: 18, weight: .light))
                }
                .padding()
                .onAppear
                {
                    // After 3 seconds, switch to the main page with animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isActive = true
                        }

                        
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
